--script for deleting MENU
--------------------------------------------------->
DECLARE
CURSOR c1 IS  SELECT menu_id, menu_name
                FROM FND_menus
               WHERE menu_name='ALP-RECIBIR WMS MOBILE';
BEGIN
FOR r IN c1 LOOP
  BEGIN
    FND_MENU_ENTRIES_pkg.DELETE_ROW (r.menu_id,20/*menu_id*/) ;
    COMMIT;
    DBMS_OUTPUT.put_line ('menu name '||r.menu_name || ' has been Purged !!!');
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.put_line ('Inner Exception: ' || SQLERRM);
    END;
END LOOP;
END;
/
--script for deleting FUNCTION
--------------------------------------------------->
DECLARE
  CURSOR c1 IS SELECT function_id ,function_name
                 FROM fnd_form_functions 
                WHERE function_name = 'XXALP_APAUXBALANCE';
BEGIN
  FOR r IN c1 LOOP
    BEGIN
      fnd_form_functions_pkg.delete_row(r.function_id/*function_id*/);
      COMMIT;
      dbms_output.put_line('funtion name '||r.function_name || ' has been Purged !!!');
    EXCEPTION
      WHEN OTHERS THEN
        dbms_output.put_line('Inner Exception: ' || SQLERRM);
    END;
  END LOOP;
END;
/
--script for deleting LOOKUP_TYPE
--------------------------------------------------->
DECLARE
BEGIN
  fnd_lookup_types_pkg.delete_row('XXALP_APAUXBALANCE_INV_STATUS' , 0/*:X_SECURITY_GROUP_ID*/ ,  0/*X_VIEW_APPLICATION_ID*/) ;
  COMMIT;
  dbms_output.put_line('lookup :'|| 'XXALP_APAUXBALANCE_INV_STATUS' || ' has been Purged !!!');
EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line('inner exception: ' || sqlerrm);
    ROLLBACK;
END;
/
--script for deleting CONCURRENT PROGRAM/EXECUTABLE
--------------------------------------------------->
BEGIN
  fnd_program.delete_program('XXALP_APAUXBALANCE','XXIMPORT Custom Application');
  dbms_output.put_line('CONCURRENT :'|| 'XXALP_APAUXBALANCE' || ' has been Purged !!!');
  --fnd_program.delete_executable('program short name','schema');
  --dbms_output.put_line('EXECUTABLE :'|| 'XXALP_APAUXBALANCE' || ' has been Purged !!!');
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line('inner exception: ' || sqlerrm);
    ROLLBACK;
END;
/
--script for deleting the DATA DEFINITION (BI PUBLISHER)
------------------------------------------------------->
BEGIN
  xdo_ds_definitions_pkg.delete_row('XXIMP','XXALP_APAUXBALANCE');
  dbms_output.put_line('DATA DEFINITION :'|| 'XXALP_APAUXBALANCE' || ' has been Purged !!!');
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line('inner exception: ' || sqlerrm);
    ROLLBACK;
END;
/
--script for deleting the TEMPLATE (BI PUBLISHER)
------------------------------------------------>
BEGIN
  xdo_templates_pkg.delete_row('XXIMP','XXALP_APAUXBALANCE');
  dbms_output.put_line('TEMPLATE :'|| 'XXALP_APAUXBALANCE' || ' has been Purged !!!');
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line('inner exception: ' || sqlerrm);
    ROLLBACK;
END;
/
DECLARE
   -- Change the following two parameters
   var_templateCode    VARCHAR2 (100) := 'XXOCSGLPERFORMANCE';     -- Template Code
   boo_deleteDataDef   BOOLEAN := TRUE;     -- delete the associated Data Def.
BEGIN
   FOR RS
      IN (SELECT T1.APPLICATION_SHORT_NAME TEMPLATE_APP_NAME,
                 T1.DATA_SOURCE_CODE,
                 T2.APPLICATION_SHORT_NAME DEF_APP_NAME
            FROM XDO_TEMPLATES_B T1, XDO_DS_DEFINITIONS_B T2
           WHERE T1.TEMPLATE_CODE = var_templateCode
                 AND T1.DATA_SOURCE_CODE = T2.DATA_SOURCE_CODE)
   LOOP
      XDO_TEMPLATES_PKG.DELETE_ROW (RS.TEMPLATE_APP_NAME, var_templateCode);

      DELETE FROM XDO_LOBS
            WHERE     LOB_CODE = var_templateCode
                  AND APPLICATION_SHORT_NAME = RS.TEMPLATE_APP_NAME
                  AND LOB_TYPE IN ('TEMPLATE_SOURCE', 'TEMPLATE');

      DELETE FROM XDO_CONFIG_VALUES
            WHERE     APPLICATION_SHORT_NAME = RS.TEMPLATE_APP_NAME
                  AND TEMPLATE_CODE = var_templateCode
                  AND DATA_SOURCE_CODE = RS.DATA_SOURCE_CODE
                  AND CONFIG_LEVEL = 50;

      DBMS_OUTPUT.PUT_LINE ('Template ' || var_templateCode || ' deleted.');

      IF boo_deleteDataDef
      THEN
         XDO_DS_DEFINITIONS_PKG.DELETE_ROW (RS.DEF_APP_NAME,
                                            RS.DATA_SOURCE_CODE);

         DELETE FROM XDO_LOBS
               WHERE LOB_CODE = RS.DATA_SOURCE_CODE
                     AND APPLICATION_SHORT_NAME = RS.DEF_APP_NAME
                     AND LOB_TYPE IN
                            ('XML_SCHEMA',
                             'DATA_TEMPLATE',
                             'XML_SAMPLE',
                             'BURSTING_FILE');

         DELETE FROM XDO_CONFIG_VALUES
               WHERE     APPLICATION_SHORT_NAME = RS.DEF_APP_NAME
                     AND DATA_SOURCE_CODE = RS.DATA_SOURCE_CODE
                     AND CONFIG_LEVEL = 30;

         DBMS_OUTPUT.PUT_LINE (
            'Data Defintion ' || RS.DATA_SOURCE_CODE || ' deleted.');
      END IF;
   END LOOP;

   DBMS_OUTPUT.PUT_LINE (
      'Issue a COMMIT to make the changes or ROLLBACK to revert.');
EXCEPTION
   WHEN OTHERS
   THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE (
         'Unable to delete XML Publisher Template ' || var_templateCode);
      DBMS_OUTPUT.PUT_LINE (SUBSTR (SQLERRM, 1, 200));
END;
/
EXIT
/
