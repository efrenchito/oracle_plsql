REM +=====================================================================+
REM |    Copyright (c) 2013 Global Solutions GROUP, Colombia              |
REM |                         All rights reserved.                        |
REM +=====================================================================+
REM | CUSTOMER                                                            |
REM |    Petroecuador                                                     |
REM |                                                                     |
REM | FILENAME                                                            |
REM |    delete_tables_bolinf.sql                                         |
REM |                                                                     |
REM | DESCRIPTION                                                         |
REM |    Statements for delete tables if they exists                      |
REM |                                                                     |
REM |                                                                     |
REM |                                                                     |
REM | LANGUAGE                                                            |
REM |    PL/SQL                                                           |
REM |                                                                     |
REM | PRODUCT                                                             |
REM |    EBS - OPM                                                        |
REM |                                                                     |
REM | SOURCE CONTROL                                                      |
REM |    Version : %I%                                                    |
REM |     Fecha  : %E% %U%                                                |
REM |                                                                     |
REM | HISTORY                                                             |
REM |    17-ABR-2013 Rocio Sanchez (GSG)                                  |
REM |                Version Inicial                                      |
REM |                                                                     |
REM +=====================================================================+
SET VERIFY OFF
WHENEVER SQLERROR EXIT FAILURE ROLLBACK;
SPOOL xxocs_delete_tables_bolinf.log


DECLARE
  l_exist NUMBER;
BEGIN
  BEGIN
    SELECT 1
      INTO l_exist
      FROM dba_tables dt
     WHERE dt.owner = 'BOLINF'
       AND dt.table_name = 'XXOCS_ACC_ALLOC_BAL_ALL';
    
    EXECUTE IMMEDIATE 'DROP TABLE bolinf.xxocs_acc_alloc_bal_all';
    
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END;
END;
/
SPOOL off
EXIT
