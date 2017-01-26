SELECT  jret.resource_name
  FROM  jtf_rs_salesreps jrs
       ,jtf_rs_resource_extns jre
       ,jtf_rs_resource_extns_tl jret
 WHERE  1 = 1
   AND jrs.salesrep_id = &p_salesrep_id
   AND jrs.org_id = ooh.org_id
   AND jre.resource_id = jrs.resource_id
   AND jret.resource_id = jre.resource_id
   AND jret.category = jre.category
   AND jret.language = USERENV('LANG')
   ;     
