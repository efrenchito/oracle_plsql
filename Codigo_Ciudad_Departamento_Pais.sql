--TRADING COMUNITY
--MEDIOS MAGNETICOS
-- ... HR_LOCATIONS/HZ_LOCATIONS
--PAISES
SELECT *
FROM   FND_LOOKUP_VALUES FLV
WHERE  1 = 1
AND    FLV.LOOKUP_TYPE = 'CLL_F041_GL_MG_COUNTRY'
AND    FLV.LANGUAGE = USERENV('LANG');
-- CIUDADES & DEPARTAMENTOS
SELECT  C.CITY_CODE
       ,SUBSTR(C.CITY_CODE, 1,2) AS COD_DPTO
       ,C.STATE AS DPTO
       ,SUBSTR(C.CITY_CODE, 3) AS COD_CITY
       ,SUBSTR(C.CITY, 1, INSTR(C.CITY, '_')-1) AS CITY
       ,C.*
  FROM CLL_F041_GL_CITY_CODES C;
---------------------------------------
-- OBTENER ORGANIZACION DE NOMINA POR ENTIDAD LEGAL
SELECT *
FROM   xxmu_pay_legal_entities_v xle
      ,hr_all_organization_units org
      ,hr_locations_all hl
WHERE  1 = 1
AND    org.organization_id = xle.organization_id
AND    hl.location_id = org.location_id
;
--- OBTENER CODIGO CIUDAD_DEPARTAMENTO, PAIS - Organización de Nomina
SELECT SUBSTR(city.city, 1, INSTR(city.city, '_')-1) AS city, city.city_code
      ,flv.description AS country, flv.meaning AS country_code
FROM   xxmu_pay_legal_entities_v xle
      ,hr_all_organization_units org
      ,hr_locations_all hl
      ,cll_f041_gl_city_codes city
      ,fnd_lookup_values flv
WHERE  1 = 1
AND    org.organization_id = xle.organization_id
AND    hl.location_id = org.location_id
AND    city.city = hl.town_or_city
AND    flv.lookup_code = hl.country
AND    flv.lookup_type = 'CLL_F041_GL_MG_COUNTRY'
AND    flv.language = USERENV('LANG');
;
---
--- OBTENER CODIGO CIUDAD_DEPARTAMENTO, PAIS - Empleado de Nomina
SELECT  pe.doc_number AS NIT
       ,pe.last_name1
       ,pe.last_name2
       ,pe.name1
       ,pe.name2
       --,pe.full_name       
       ,pad.address_line1 AS DIRECCION --CONVERT(pad.address_line1, 'US7ASCII')
       ,SUBSTR(city.city_code,1,2) AS COD_DPTO
       ,city.state AS DPTO
       ,SUBSTR(city.city_code, 3) AS COD_CITY
       ,SUBSTR(city.city, 1, INSTR(city.city, '_')-1) AS CITY
       ,country.meaning AS COD_PAIS
       ,country.description AS PAIS
      ----------       
      ,pad.country pais
      ,pad.region_2 departamento
      ,pad.town_or_city ciudad
      ,pad.*
  FROM  xxmu_pay_employ_assignments_v pe
       ,per_addresses pad
       ,cll_f041_gl_city_codes city
       ,fnd_lookup_values country
 WHERE  1 = 1  
   AND  pad.person_id(+) = pe.person_id
   AND  pad.primary_flag(+) = 'Y'
   AND  pe.ass_end_date >= pad.date_from(+)
   AND  pe.ass_end_date < NVL(pad.date_to(+),pe.ass_end_date) + 1
   AND  city.city(+) = pad.town_or_city
   AND  country.lookup_code(+) = pad.country
   AND  country.lookup_type(+) = 'CLL_F041_GL_MG_COUNTRY'
   AND  country.language(+) = USERENV('LANG')
   ;
