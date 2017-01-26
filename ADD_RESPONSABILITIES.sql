SELECT Fcp.User_Concurrent_Program_Name, Fr.Request_Group_Name
FROM   Fnd_Concurrent_Programs_Vl Fcp
      ,Fnd_Request_Group_Units    Frgu
      ,Fnd_Request_Groups         Fr
WHERE  Fcp.Concurrent_Program_Id = Frgu.Request_Unit_Id
AND    Frgu.Request_Group_Id = Fr.Request_Group_Id
AND    Fcp.User_Concurrent_Program_Name LIKE 'XXOCS%Import%'
;

--------------------------------------------------SELECCION_RESP---------------------------------------------------------------

SELECT FAV.APPLICATION_SHORT_NAME, FAV.APPLICATION_NAME,FRV.RESPONSIBILITY_KEY, FRV.RESPONSIBILITY_NAME
FROM FND_APPLICATION_VL FAV, FND_RESPONSIBILITY_VL FRV
WHERE FRV.APPLICATION_ID=FAV.APPLICATION_ID
      AND UPPER(FRV.RESPONSIBILITY_NAME) LIKE UPPER('&NOMBRE_RESP')
ORDER BY FRV.RESPONSIBILITY_NAME;

--------------------------------------------------ADDRESP----------------------------------------------------------------------
BEGIN   --fnd_user_pkg.addresp('USERNAME'      ,'APP_SHORT_NAME','RESPONSIBILITY_KEY'         ,'STANDARD','Add Responsibility to USER using pl/sql',SYSDATE-400,null);  
        --fnd_user_pkg.addresp('MVARGAS'       ,'XDO'           ,'XDO_ADMINISTRATION'         ,'STANDARD','Add Responsibility to USER using pl/sql',SYSDATE-400,null);
        --fnd_user_pkg.addresp('MVARGAS'       ,'FRM'           ,'FRM_REPORT_MANAGER_SECURITY','STANDARD','Add Responsibility to USER using pl/sql',SYSDATE-400,null);
          fnd_user_pkg.addresp('MILTON.VARGAS','PER'           ,'RESPONSIBILITY_KEY','STANDARD','Add Responsibility to USER using pl/sql',SYSDATE-400,null);
        COMMIT;
        DBMS_OUTPUT.put_line('Responsibility Added Successfully');
EXCEPTION
        WHEN OTHERS
        THEN
        DBMS_OUTPUT.put_line(' Responsibility is not added due to ' || SQLCODE || SUBSTR(SQLERRM, 1, 100));
        ROLLBACK;
END;


-------------------------------------------------CHANGEPASSWORD----------------------------------------------------------------
begin
if fnd_user_pkg.changepassword('JESUS.ARROYAVE','chucho456') then
null;

end if;
end;


xxmu_pay_relation_entity_pkg
