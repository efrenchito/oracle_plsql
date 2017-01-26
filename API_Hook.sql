select module_name from hr_api_modules where api_module_type = 'AI';


SELECT HC.CALL_PACKAGE, HC.CALL_PROCEDURE, HC.SEQUENCE, HC.ENABLED_FLAG, H.api_module_id, HAM.API_MODULE_TYPE, HAM.MODULE_NAME, H.API_HOOK_TYPE
  FROM HR_API_HOOK_CALLS  HC
      ,HR_API_HOOKS H
      ,HR_API_MODULES HAM
 WHERE 1=1 
   AND H.HOOK_PROCEDURE IN ('CREATE_PERSON_ABSENCE_A', 'DELETE_PERSON_ABSENCE_A')
   AND HC.API_HOOK_ID = H.API_HOOK_ID
   AND HAM.api_module_id = h.api_module_id
   ;

--API_HOOKS
SELECT * FROM HR_API_HOOKS WHERE 1=1 AND api_hook_id IN (3840, 4846);
SELECT * FROM HR_API_MODULES M WHERE M.API_MODULE_ID IN (1731, 2217);
/*
IMPLEMENTING USER HOOKS
:::::::::::::::::::::....
There are basically 4 steps to implementing API User Hooks.
1. Choose the API you wish to hook some extra logic to.
2. Write the PL/SQL procedure that you wish to be called by the hook.
3. Register or associate the procedure you have written with one or more specific user hooks.
4. Run the pre-processor program which builds the logic to execute your 
   PL/SQL procedure from the hook specified in 3.

There are 5 different types of User Hook. 
  - Two for Business Process APIs (Before Process and After Process)
  - ,and 3 more for Row Handler APIs (After Insert,After Update and After Delete).
*/


-- 1. Choose the API you wish to hook some extra logic to.
SELECT  ahk.api_hook_id
       ,ahk.api_module_id
       ,ahk.hook_package
       ,ahk.hook_procedure
       , ahm.module_Name
  from  hr_api_hooks ahk
       ,hr_api_modules ahm
 where  1 = 1
   AND  ahm.module_name IN ('CREATE_PERSON_ABSENCE', 'DELETE_PERSON_ABSENCE')
   and  ahm.api_module_type = 'BP'
   and  ahk.api_hook_type = 'AP'
   and  ahk.api_module_id=ahm.api_module_id;
---
SELECT  ahk.api_hook_id
       ,ahk.hook_package
       ,ahk.hook_procedure
  from  hr_api_hooks ahk
       ,hr_api_modules ahm
 where (ahm.module_name='PER_ALL_PEOPLE_F'
       or ahm.module_name='PER_PEOPLE_F')
   and ahm.api_module_type = 'RH'
   and ahk.api_hook_type = 'AI'
   AND ahk.api_module_id=ahm.api_module_id;
/*
Using User Hooks
:::::::::::::....
After choosing the type of hook required and the location for it, the hook code
has to be written. It then needs to be registered, and finally the hook package
has to be modified to call it.

2. Write the PL/SQL procedure that you wish to be called by the hook. 
   Writing the custom PL/SQL procedure
   -----------------------------------
Any conditional logic must be implemented in the code and an application error raised if required
No commits or rollbacks are allowed in the hook procedure. These are always performed after the 
API has been called whether it be in a PL/SQL wrapper or form.
When the PL/SQL package has been created, it must be compiled successfully on the database.


3. Register or associate the procedure you have written with one or more specific user hooks.
   Registering the User Hook
   --------------------------
The next step is to link the custom package procedure referred to in section 1 
(Writing the custom PL/SQL procedure to the hook package.)
The table that holds this information is HR_API_HOOK_CALLS.*/
SELECT * FROM HR_API_HOOK_CALLS WHERE 1=1 AND api_hook_id IN (3840, 4846);
/*There are 3 special procedures that maintain data in this table. These are
. hr_api_hook_call_api.create_api_hook_call
. hr_api_hook_call_api.update_api_hook_call
. hr_api_hook_call_api.delete_api_hook_call
*/
DECLARE
l_api_hook_call_id number;
l_object_version_number number;
BEGIN
  hr_api_hook_call_api.create_api_hook_call
  (
      p_validate => false,
      p_effective_date => to_date('01-JUL-1999','DD-MON-YYYY'),
      p_api_hook_id => 63,  --section 1. Choose the API you wish to hook some extra logic to.
      p_api_hook_call_type => 'PP', --only supports calls to package procedures currently so api_hook_call_type must be PP.
      p_sequence => 3000, --> 2000 are recommended, as sequences < than 2000 are reserved for Oracle seeded logic which needs to be processed first 
      p_enabled_flag => 'Y',
      p_call_package => 'SCOOP_NATIONALITY_CHECK',
      p_call_procedure => 'POLISH_NAME_CHECK',
      p_api_hook_call_id => l_api_hook_call_id,
      p_object_version_number => l_object_version_number
  );
END;


/*4. 
Run the pre-processor program which builds the logic to execute your 
PL/SQL procedure from the hook specified in 3.*/
--To run the pre-processor run one of the following commands:
cd $PER_TOP/admin/SQL | $PER_TOP/patch/115/sql
--Log into SQLPLUS as the APPS user
SQL> @hrahkall.sql

--or

SQL> @hrahkone.sql

/*The first script will create all hook package bodies, whilst the second will
create hook package bodies for one API module only, and prompt for that
api_module_id.
==========================================================
Sometimes if you don't have server credentials then you can use below alternative to run the pre-processor through sqlplus 
Log in to database through apps*/

SQL> @hrahkall.sql

--instead of running above script you can execute below statement

exec hr_api_user_hooks_utility.create_hooks_all_modules;

SQL> @hrahkone.sql

--instead of running above script you can execute below statement

exec hr_api_user_hooks_utility.create_hooks_one_module(p_module_id);
