SELECT * FROM hr_all_organization_units;
SELECT * FROM hr_organization_units;
SELECT * FROM mtl_parameters mtl;
SELECT * FROM hr_operating_units;
SELECT * FROM hr_organization_information;
SELECT * FROM org_organization_definitions;
SELECT * FROM xle_le_ou_ledger_v;
SELECT * FROM xle_firstparty_information_v;

--Lista organizaciones a las que un  usuario tiene acceso
 SELECT hao.organization_id, hao.name
FROM org_access oa
,hr_all_organization_units hao
WHERE hao.organization_id = oa.organization_id
AND oa.resp_application_id = fnd_global.resp_appl_id
AND oa.responsibility_id = fnd_global.resp_id;
 
--Lista organizaciones e informacion:
SELECT o.organization_id,o.name, hoi.org_information_context 
FROM hr_all_organization_units o
,hr_organization_information hoi
WHERE hoi.organization_id = o.organization_id
AND hoi.org_information_context = 'Accounting Information'; 
 
--Informacion unidad operativa:
SELECT o.organization_id,o.name, hoi.org_information_context 
FROM hr_all_organization_units o
,hr_organization_information hoi
WHERE hoi.organization_id = o.organization_id
AND hoi.org_information_context = 'Operating Unit Information'; 
 ua

--- Entidades legales de una Unidad Operativa
SELECT hou.organization_id,xep.legal_entity_id,xep.name legal_entity_name
FROM hr_operating_units hou
   , xle_entity_profiles xep
WHERE hou.organization_id = fnd_profile.value('org_id')
  AND hou.default_legal_context_id = xep.legal_entity_id;
   
SELECT * FROM hr_all_organization_units o;
SELECT * FROM hr_operating_units hou;
SELECT * FROM hr_organization_information hoi;
SELECT * FROM xle_entity_profiles xep;

SELECT * FROM fnd_profile.value('org_id') FROM dual;

--- Entidades legales de una Unidad Operativa
SELECT hou.organization_id,xep.legal_entity_id,xep.name legal_entity_name
FROM hr_operating_units hou
   , xle_entity_profiles xep
WHERE hou.organization_id = fnd_profile.value('org_id')
  AND hou.default_legal_context_id = xep.legal_entity_id;
  
--  Organizacion Continua o Discreta
---------------------------------
--En la tabla MTL_PARAMETERS el campo PROCESS_ENABLED_FLAG nos indica:
    si la organizacion es continua  = 'Y'
                         o discreta = 'N'  
