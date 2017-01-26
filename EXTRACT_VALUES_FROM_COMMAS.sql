--http://stackoverflow.com/questions/7028098/how-to-parse-comma-delimited-string-in-pl-sql

DECLARE
     v_array apex_application_global.vc_arr2;
     v_string varchar2(2000);
   BEGIN
   
     -- Convert delimited string to array
     v_array := apex_util.string_to_table('&P_TEXTO', ',');
     FOR i IN 1..v_array.count
         LOOP
           dbms_output.put_line(v_array(i));
         END LOOP;
END;


SELECT   num_value
  FROM   (    SELECT   TRIM (REGEXP_SUBSTR (num_csv,'[^,]+',1,LEVEL))
                          num_value
                FROM   (    SELECT   '1,E2,3,4,5,6,7,8,9,10' num_csv FROM DUAL)
          CONNECT BY   LEVEL <= regexp_count (num_csv, ',', 1) + 1)
 WHERE   num_value IS NOT NULL;
