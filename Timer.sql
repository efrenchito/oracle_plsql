BEGIN
   dbms_lock.sleep(15);
   dbms_output.put_line('tic toc');
END;
