-- Genera una columna tipo CLOB con la capacidad que este tipo de dato representa
select 
   xep.geography_id,
   xmlagg (xmlelement (e, xep.name || ',')).extract ('//text()') LEGAL_ENTITY
   -- ,LISTAGG(emp.assignment_id, ',')WITHIN GROUP(ORDER BY emp.assignment_id) assignment_list
from 
   xle_entity_profiles xep
group by 
   xep.geography_id
;
-- PARA NO mostrar la ultima ',' --> Si la cadena de caracteres es demasiado larga genera error de BUFFER... 
select 
   xep.geography_id,
   rtrim (xmlagg (xmlelement (e, xep.name || ',')).extract ('//text()'), ',') LEGAL_ENTITY
from 
   xle_entity_profiles xep
group by 
   xep.geography_id
;

xxmu_oportunidad_venta
