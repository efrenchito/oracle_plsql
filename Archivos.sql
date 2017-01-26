/*
Oracle/PL/SQL/UTL FILE
Para leer o escribir archivos es necesario crear un objeto directory desde SQL:
*/
 create directory dir_tmp as 'c:\temp';
 grant read, write on directory dir_tmp to usuario;

 
--Escritura
create or replace procedure escribir is
  v_archivo utl_file.file_type;
begin
  v_archivo := utl_file.fopen ('DIR_TMP', 'test_utl_file.txt', 'w');

  utl_file.put_line (v_archivo, 'Prueba de escritura');

  utl_file.put (v_archivo, 'Texto sin fin de línea');
  utl_file.put_line (v_archivo, ' que sigue y termina acá.');

  utl_file.fclose(v_archivo); 
end;
/

--Lectura
create or replace procedure leer is
  v_archivo utl_file.file_type;
  v_linea varchar2(1024);
begin
  v_archivo := utl_file.fopen ('DIR_TMP', 'test_utl_file.txt', 'r');
  loop
    utl_file.get_line (v_archivo, v_linea);
    dbms_output.put_line (v_linea);
  end loop;
  utl_file.fclose(v_archivo); 

exception
  when no_data_found then
    dbms_output.put_line ('Fin del archivo');
end;
/

/*
Manejo de Errores
Si otro proceso tiene abierto y bloqueado el archivo:
*/
create or replace procedure abrir_bloqueado is
  v_archivo utl_file.file_type;
begin
  v_archivo := utl_file.fopen ('DIR_TMP', 'test_utl_file.txt', 'w');
  utl_file.fclose(v_archivo); 
  dbms_output.put_line ('Ok');

exception
  when utl_file.invalid_operation then
    dbms_output.put_line ('Error: utl_file.invalid_operation');
end;
/
Si no hay permisos de lectura:
create or replace procedure abrir_no_lectura is
  v_archivo utl_file.file_type;
begin
  v_archivo := utl_file.fopen ('DIR_TMP', 'test_utl_file.txt', 'r');
  utl_file.fclose(v_archivo); 
  dbms_output.put_line ('Ok');

exception
  when utl_file.access_denied then
    dbms_output.put_line ('Error: utl_file.access_denied');
end;
/
Si el archivo no existe:
create or replace procedure abrir_no_existe is
  v_archivo utl_file.file_type;
begin
  v_archivo := utl_file.fopen ('DIR_TMP', 'test_no_existe.txt', 'r');
  utl_file.fclose(v_archivo); 
  dbms_output.put_line ('Ok');

exception
  when utl_file.invalid_operation then
    dbms_output.put_line ('Error: utl_file.invalid_operation');
end;
/