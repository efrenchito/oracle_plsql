/*--SET PASSWORD
BEGIN
IF fnd_user_pkg.changepassword('SYSADMIN','V5bSF4mb213') THEN
NULL;

END IF;
END;
*/

/*
--Step 1. Create get_pwd package specification, as shown below.
	CREATE OR REPLACE PACKAGE get_pwd AS FUNCTION decrypt ( KEY IN VARCHAR2 
	,VALUE IN VARCHAR2 ) RETURN VARCHAR2; END get_pwd; 

	--DROP PACKAGE get_pwd
  
	--Step 2. Create get_pwd package body, as shown below.
	CREATE OR REPLACE PACKAGE BODY get_pwd AS FUNCTION decrypt ( KEY IN VARCHAR2,VALUE IN VARCHAR2 ) RETURN VARCHAR2 AS LANGUAGE JAVA NAME 
	'oracle.apps.fnd.security.WebSessionManagerProc.decrypt(java.lang.String,java.lang.String) return java.lang.String'; END get_pwd;

*/

--Step 3. Query to get password for apps user. RELEASE 12
SELECT usertable.user_name
      ,(SELECT get_pwd.decrypt(UPPER((SELECT (SELECT get_pwd.decrypt(UPPER((SELECT upper(FND_WEB_SEC.GET_GUEST_USERNAME_PWD)
                                                                            FROM dual)),
                                                                    usertable.encrypted_foundation_password)
                                               FROM dual) AS apps_password
                                       FROM fnd_user usertable
                                      WHERE usertable.user_name LIKE
                                            upper((SELECT substr(FND_WEB_SEC.GET_GUEST_USERNAME_PWD,
                                                                1,
                                                                instr(FND_WEB_SEC.GET_GUEST_USERNAME_PWD,
                                                                      '/') - 1)
                                                    FROM dual)))),
                               usertable.encrypted_user_password)
          FROM dual) AS encrypted_user_password
  FROM fnd_user usertable
 WHERE usertable.user_name LIKE upper('&username');
--RELEASE 11
SELECT usertable.user_name,
       (SELECT get_pwd.decrypt(UPPER((SELECT (SELECT get_pwd.decrypt(UPPER((SELECT upper(fnd_profile.value('GUEST_USER_PWD'))
                                                                            FROM dual)),
                                                                    usertable.encrypted_foundation_password)
                                               FROM dual) AS apps_password
                                       FROM fnd_user usertable
                                      WHERE usertable.user_name LIKE
                                            upper((SELECT substr(fnd_profile.value('GUEST_USER_PWD'),
                                                                1,
                                                                instr(fnd_profile.value('GUEST_USER_PWD'),
                                                                      '/') - 1)
                                                    FROM dual)))),
                               usertable.encrypted_user_password)
          FROM dual) AS encrypted_user_password
  FROM fnd_user usertable
 WHERE usertable.user_name LIKE upper('&username');

 
 --Get Apps_pwd if you have access via FTP
/*
STEP1. Create Host/Shell Script Concurrent Program in R12 with execution file name linked to 'XXPASS'
STEP2. Create XXPASS.prog file in $CUSTOM_TOP/bin as follows: 
 #!/bin/ksh
 
# Environmental Variables :
ORA_USER_PASS=$1
USERID=$2
USERNAME=$3
REQUESTID=$4
RELATIVE_PATH="$5"    #Relative File Path
 
echo "--------Parameters---------";
echo "ORA USER PASS     :" $ORA_USER_PASS
echo "USERID            :" $USERID
echo "USERNAME          :" $USERNAME
echo "REQUESTID         :" $REQUESTID
echo "RELATIVE PATH     :" $RELATIVE_PATH
echo " "
exit 0;
STEP3. Change Permissions to 755 for the XXPASS.prog file. ($chmod 755 $CUSTOM_TOP/bin/XXPASS.prog)
STEP4. Create soft Link to the shell Script ( ln -s $FND_TOP/bin/fndcpesr   $CUSTOM_TOP/bin/XXPASS) to create XXPASS file.
STEP5. Submit the concurrent program from Added responsibility and view the log file
*/
