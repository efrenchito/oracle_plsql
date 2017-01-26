CREATE TABLE text_proyectos
( 
   orden number,
   proyecto varchar2(30),
   actividad varchar2(15),
   supervisor varchar(8)
)
 ORGANIZATION EXTERNAL
(
 DEFAULT DIRECTORY texternal_data
 ACCESS PARAMETERS
(
   RECORDS delimited BY newline
   fields terminated BY ','
)
 LOCATION ('proyectos.csv')
)
/
EXECUTE IMMEDIATE(
     'ALTER TABLE '
     || p_table_name
     || ' DEFAULT DIRECTORY '
     || p_directory
     || ' LOCATION ('''
     || p_filename
     || ''') '
     || ' ACCESS PARAMETERS ('
     || TO_CHAR(new_access_params)
     || ')'
  );
/
ALTER TABLE ext_table
  ACCESS PARAMETERS
   (
     records delimited by newline 
     badfile admin_bad_dir:'empxt%a_%p.bad' 
     logfile admin_log_dir:'empxt%a_%p.log' 
     fields terminated by ',' 
     missing field values are null 
     ( field1, field2 ) 
  );
