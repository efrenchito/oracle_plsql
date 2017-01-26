SELECT fr.responsibility_name, 
       fu.user_id, 
       fr.responsibility_id resp_id, 
       furg.responsibility_application_id resp_appl_id
FROM apps.fnd_user_resp_groups furg
   , apps.fnd_user fu
   , apps.fnd_responsibility_vl fr
--, apps.fnd_responsibility fr
--, apps.fnd_responsibility_tl frt
WHERE 1 = 1
AND  upper(fu.user_name) = upper('&User_Name')
AND furg.user_id = fu.user_id
AND furg.responsibility_id = fr.responsibility_id
--AND furg.responsibility_id = fr.responsibility_id
--AND fr.responsibility_id = frt.responsibility_id
--AND fr.application_id = frt.application_id
--AND frt.language = 'US' --USERENV('LANG')
ORDER BY fr.responsibility_name
;

SELECT *
FROM   apps.fnd_user fu
WHERE  fu.user_Name = 'SYSADMIN'
;

SELECT frt.*
FROM   apps.fnd_responsibility fr
     , apps.fnd_responsibility_tl frt
WHERE  fr.responsibility_id = frt.responsibility_id
AND    fr.application_id = frt.application_id
;

SELECT org.organization_id, org.organization_name, org.*
FROM   org_organization_definitions org
WHERE  UPPER(org.organization_name) LIKE '%ANDERCOL%'
;

DECLARE
BEGIN
--mo_global.set_policy_context('S',4346);
fnd_global.apps_initialize (&user_id, &resp_id, &resp_appl_id);
BEGIN
fnd_global.apps_initialize (1233, 58566,  1);
--******************************************************
OCS_PO_SUPERUSUARIO	1154	50678	201

--ADMINISTRADOR DE SISTEMA	      1233,	20420, 1
--ADMINISTRADOR DE XML PUBLISHER  1233,	24195, 603
--DESARROLLADOR DE APLICACIONES	  1233,	20419, 0
--DIAGNÓSTICO DE APLICACIÓN	      1233,	55869, 0
--INVENTARIO	                  1233,	20634, 401
--XX Customizaciones	          1233,	50948, 20003
--******************************************************
--ADC_ZZ_BI_REPORTES_ZZ_SUPER_USUARIO	1233,	53301, 1
--CGP_ZZ_BI_REPORTES_ZZ_SUPER_USUARIO	1233,	52744, 1
--CML_ZZ_BI_REPORTES_ZZ_SUPER_USUARIO	1233,	58566, 1
--CSM_ZZ_BI_REPORTES_ZZ_SUPER_USUARIO	1233,	53302, 1
--GM_ZZ_INV_SUPER_USUARIO	            1233,	51042, 401
--IMS_ZZ_BI_REPORTES_ZZ_SUPER_USUARIO	1233,	53303, 1
--OTK_ZZ_BI_REPORTES_ZZ_SUPER_USUARIO	1233,	56182, 275
--PCN_ZZ_BI_REPORTES_ZZ_SUPER_USUARIO	1233,	56793, 401
--PIE_ZZ_BI_REPORTES_ZZ_SUPER_USUARIO	1233,	57292, 1
--PLQ_ZZ_BI_REPORTES_ZZ_SUPER_USUARIO	1233,	57293, 1
--TSC_ZZ_BI_REPORTES_ZZ_SUPER_USUARIO	1233,	56412, 1
--VNP_VE_GL_GAAP_SUPER_USUARIO		    1131,	60016, 101
--ITQ_VE_GL_GAAP_SUPER_USUARIO	 	    1131,	60164, 101
END;
---- 
EXEC fnd_global.apps_initialize (&user_id, &resp_id, &resp_appl_id);

------------------------------------------------------------------------
DECLARE
  l_user_id fnd_user.user_id%TYPE;
  l_user_name fnd_user.user_name%TYPE := 'USUARIO.DATOS';
  l_application_id fnd_responsibility.application_id%TYPE;
  l_responsibility_id fnd_responsibility.responsibility_id%TYPE;
  
BEGIN

  BEGIN
    SELECT USER_ID  INTO l_user_id FROM  fnd_user WHERE user_name = l_user_name;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      dbms_output.put_line('NO SE ENCONTRARON DATOS DE USUARIO');
  END;
  
  BEGIN
    SELECT F.APPLICATION_ID, F.RESPONSIBILITY_ID 
      INTO l_application_id, l_responsibility_id
    FROM   apps.FND_RESPONSIBILITY_VL F
    WHERE  SYSDATE BETWEEN F.START_DATE AND NVL(F.END_DATE,SYSDATE)
      AND    F.RESPONSIBILITY_NAME =  'OTK_ZZ_BI_REPORTES_ZZ_SUPER_USUARIO';
      --OTC_CO_AR_SUPER_USUARIO
      --CSM_CO_HR_DISCOVERER
      --ADC_CO_BI_REPORTES_QA_JEFE_DE_GESTION_CALIDAD
      --GM_CO_HR_SUPER_USUARIO
      --CGP_ZZ_BI_REPORTES_SUPER_USUARIO
      --GM_ZZ_BI_REPORTES_SUPER_USUARIO
      --CGP_CO_OPM_SUPERVISOR_DE_PRODUCCION
      --CGP_CO_IM_ADMINISTRADOR_IMPORTACIONES
      --CGP_CO_BI_REPORTES_OPM_SUPERVISOR_PRODUCCION
      --CGP_CO_BI_REPORTES_GL_SUPER_USUARIO
      --ADC_CO_OPM_FORMULADOR
      --ADC_CO_OPM_INTERFAZ_BATCH
      --GM_ZZ_INV_GEN_INFORMES
      --GM_CO_OPM_INTERFAZ_BATCH
      --CGP_CO_BI_REPORTES_CM_ANALISTA_DE_COSTOS
      --CGP_CO_BI_REPORTES_AR_SUPER_USUARIO
      --ADC_CO_BI_REPORTES_IM_LOGISTICA
      --ADC_ZZ_BI_REPORTES_SUPER_USUARIO
      --CGP_CO_OPM_FINANZAS
      --CGP_CO_AR_ADMINISTRADOR
      --MLS_CO_BI_REPORTES_IM_DIRECTOR_CEDI_MLS
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      dbms_output.put_line('NO SE ENCONTRARON DATOS DE LA RESPONSABILIDAD');
  END;
  
  
  FND_GLOBAL.APPS_INITIALIZE(l_user_id, l_responsibility_id, l_application_id);
  MO_GLOBAL.init('M');
  dbms_output.put_line('Registro OK');
  dbms_output.put_line(FND_GLOBAL.RESP_NAME);
  
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Error = ' || SQLCODE);
      dbms_output.put_line('Mensaje = ' || SUBSTR(SQLERRM, 1, 2000));
END;

--ACTIVAR ORGANIZACION
---
BEGIN mo_global.set_org_context(to_char(fnd_global.org_id),NULL,fnd_global.application_short_name); 
EXCEPTION WHEN OTHERS THEN FND_REQUEST.set_org_id(org_id => fnd_global.org_id); 
xx_debug_pk.debug(sqlerrm);
NULL;
END;


BEGIN mo_global.set_org_context(to_char(fnd_global.org_id),NULL,fnd_global.application_short_name); 
EXCEPTION WHEN OTHERS THEN FND_REQUEST.set_org_id(org_id => fnd_global.org_id); xx_debug_pk.debug(sqlerrm);
NULL;
END;
