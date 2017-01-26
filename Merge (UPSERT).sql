/*
MERGE Statement
The MERGE statement was introduced in Oracle 9i to conditionally insert or update data depending on its presence, a process also known as an "upsert". The MERGE statement reduces table scans and can perform the operation in parallel if required.

Syntax
Performance
Related articles.

MERGE Statement Enhancements in Oracle Database 10g
Syntax

Consider the following example where data from the HR_RECORDS table is merged into the EMPLOYEES table.
*/
MERGE INTO employees e
    USING hr_records h
    ON (e.id = h.emp_id)
  WHEN MATCHED THEN
    UPDATE SET e.address = h.address
  WHEN NOT MATCHED THEN
    INSERT (id, address)
    VALUES (h.emp_id, h.address);
--The source can also be a query.

MERGE INTO employees e
    USING (SELECT * FROM hr_records WHERE start_date > ADD_MONTHS(SYSDATE, -1)) h
    ON (e.id = h.emp_id)
  WHEN MATCHED THEN
    UPDATE SET e.address = h.address
  WHEN NOT MATCHED THEN
    INSERT (id, address)
    VALUES (h.emp_id, h.address);
/*
Performance

The MERGE statement is optimized for merging sets of data, rather than single rows, as shown in the example below.

Create the following test tables. The source table contains all the rows from the ALL_OBJECTS view, while the destination table contains approximately half of the rows.
*/
CREATE TABLE source_tab AS
SELECT object_id, owner, object_name, object_type
FROM   all_objects;

ALTER TABLE source_tab ADD (
  CONSTRAINT source_tab_pk PRIMARY KEY (object_id)
);

CREATE TABLE dest_tab AS
SELECT object_id, owner, object_name, object_type
FROM   all_objects WHERE ROWNUM <= 25000;

ALTER TABLE dest_tab ADD (
  CONSTRAINT dest_tab_pk PRIMARY KEY (object_id)
);

EXEC DBMS_STATS.gather_table_stats(USER, 'source_tab', cascade=> TRUE);
EXEC DBMS_STATS.gather_table_stats(USER, 'dest_tab', cascade=> TRUE);
--The following code compares the performance of four merge operations. The first uses the straight MERGE statement. The second also uses the MERGE statement, but in a row-by-row manner. The third performs an update, and conditionally inserts the row if the update touches zero rows. The fourth inserts the row, then performs an update if the insert fails with a duplicate value on index exception.

SET SERVEROUTPUT ON
DECLARE
  TYPE t_tab IS TABLE OF source_tab%ROWTYPE;
  
  l_tab   t_tab;
  l_start NUMBER;
BEGIN

  l_start := DBMS_UTILITY.get_time;
  
  MERGE INTO dest_tab a
    USING source_tab b
    ON (a.object_id = b.object_id)
    WHEN MATCHED THEN
      UPDATE SET
        owner       = b.owner,
        object_name = b.object_name,
        object_type = b.object_type
    WHEN NOT MATCHED THEN
      INSERT (object_id, owner, object_name, object_type)
      VALUES (b.object_id, b.owner, b.object_name, b.object_type);

  DBMS_OUTPUT.put_line('MERGE        : ' || 
                       (DBMS_UTILITY.get_time - l_start) || ' hsecs');

  ROLLBACK;

  l_start := DBMS_UTILITY.get_time;

  SELECT *
  BULK COLLECT INTO l_tab
  FROM source_tab;
    
  FOR i IN l_tab.first .. l_tab.last LOOP
    MERGE INTO dest_tab a
      USING (SELECT l_tab(i).object_id AS object_id,
                    l_tab(i).owner AS owner,
                    l_tab(i).object_name AS object_name,
                    l_tab(i).object_type AS object_type
             FROM dual) b
      ON (a.object_id = b.object_id)
      WHEN MATCHED THEN
        UPDATE SET
          owner       = b.owner,
          object_name = b.object_name,
          object_type = b.object_type
      WHEN NOT MATCHED THEN
        INSERT (object_id, owner, object_name, object_type)
        VALUES (b.object_id, b.owner, b.object_name, b.object_type);
  END LOOP;

  DBMS_OUTPUT.put_line('ROW MERGE    : ' || 
                       (DBMS_UTILITY.get_time - l_start) || ' hsecs');

  ROLLBACK;

  l_start := DBMS_UTILITY.get_time;

  SELECT *
  BULK COLLECT INTO l_tab
  FROM source_tab;
    
  FOR i IN l_tab.first .. l_tab.last LOOP
    UPDATE dest_tab SET
      owner       = l_tab(i).owner,
      object_name = l_tab(i).object_name,
      object_type = l_tab(i).object_type
    WHERE object_id = l_tab(i).object_id;
    
    IF SQL%ROWCOUNT = 0 THEN
      INSERT INTO dest_tab (object_id, owner, object_name, object_type)
      VALUES (l_tab(i).object_id, l_tab(i).owner, l_tab(i).object_name, l_tab(i).object_type);
    END IF;
  END LOOP;

  DBMS_OUTPUT.put_line('UPDATE/INSERT: ' || 
                       (DBMS_UTILITY.get_time - l_start) || ' hsecs');

  ROLLBACK;

  l_start := DBMS_UTILITY.get_time;

  SELECT *
  BULK COLLECT INTO l_tab
  FROM source_tab;
    
  FOR i IN l_tab.first .. l_tab.last LOOP
    BEGIN
      INSERT INTO dest_tab (object_id, owner, object_name, object_type)
      VALUES (l_tab(i).object_id, l_tab(i).owner, l_tab(i).object_name, l_tab(i).object_type);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        UPDATE dest_tab SET
          owner       = l_tab(i).owner,
          object_name = l_tab(i).object_name,
          object_type = l_tab(i).object_type
        WHERE object_id = l_tab(i).object_id;
    END;    
  END LOOP;

  DBMS_OUTPUT.put_line('INSERT/UPDATE: ' || 
                       (DBMS_UTILITY.get_time - l_start) || ' hsecs');

  ROLLBACK;
END;
/

/*
MERGE       : 119 hsecs
ROW MERGE    : 1453 hsecs
UPDATE/INSERT: 1280 hsecs
INSERT/UPDATE: 2443 hsecs

PL/SQL procedure successfully completed.

SQL>
The output shows the straight MERGE statement is an order of magnitude faster than its nearest rival. The update/insert performs almost twice the speed of the insert/update and even out performs the row-by-row MERGE.

In addition to the straight MERGE statement being faster, because it is a DML statement it can easily be run in parallel to improve performance further, provided your server can handle the extra load.
*/
