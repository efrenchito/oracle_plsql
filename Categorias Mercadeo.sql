SELECT   msi.segment1               
                ,(SELECT  NVL(ffvv.description, ffvv.FLEX_VALUE_meaning ) nombre 
                  FROM FND_ID_FLEX_SEGMENTS_VL fifsv
                    , FND_FLEX_VALUE_SETS ffv
                    , FND_FLEX_VALUES_VL ffvv 
                  WHERE APPLICATION_ID = 401 
                    AND  ffvv.FLEX_VALUE_SET_ID = ffv.FLEX_VALUE_SET_ID 
                    AND  ID_FLEX_NUM = (SELECT id_flex_num FROM FND_ID_FLEX_STRUCTURES_VL WHERE application_id = 401 AND id_flex_code = 'MCAT' AND id_flex_structure_code = 'GM_ZZ_CAT_MERCADEO_' || hc.hierarchy_code) 
                    AND fifsv.SEGMENT_NUM = 10 
                    AND  ffvv.FLEX_VALUE_MEANING = mc.SEGMENT1
                    AND  FLEX_VALUE_SET_NAME LIKE 'GM_ZZ_CAT_MERCADEO_'||substr(hc.hierarchy_code,1,4) ||'%_' || substr(replace(fifsv.segment_name, ' ', '_'), 1, 10)
                    AND ROWNUM = 1
                ) AS UEN
                ,(SELECT  NVL( ffvv.description, ffvv.FLEX_VALUE_meaning ) nombre 
                  FROM FND_ID_FLEX_SEGMENTS_VL fifsv
                    , FND_FLEX_VALUE_SETS ffv
                    , FND_FLEX_VALUES_VL ffvv 
                  WHERE APPLICATION_ID = 401 
                    AND  ffvv.FLEX_VALUE_SET_ID = ffv.FLEX_VALUE_SET_ID 
                    AND  ID_FLEX_NUM = (SELECT id_flex_num FROM FND_ID_FLEX_STRUCTURES_VL WHERE application_id = 401 AND id_flex_code = 'MCAT' AND id_flex_structure_code = 'GM_ZZ_CAT_MERCADEO_' || hc.hierarchy_code) 
                    AND fifsv.SEGMENT_NUM = 20 
                    AND  ffvv.FLEX_VALUE_MEANING = mc.SEGMENT2
                    AND  FLEX_VALUE_SET_NAME LIKE 'GM_ZZ_CAT_MERCADEO_'||substr(hc.hierarchy_code,1,4) ||'%_' || substr(replace(fifsv.segment_name, ' ', '_'), 1, 10)
                    AND ROWNUM = 1
                  ) AS MARCA_CORPORATIVA
                ,(SELECT  NVL( ffvv.description, ffvv.FLEX_VALUE_meaning ) nombre 
                  FROM FND_ID_FLEX_SEGMENTS_VL fifsv
                    , FND_FLEX_VALUE_SETS ffv
                    , FND_FLEX_VALUES_VL ffvv 
                  WHERE APPLICATION_ID = 401 
                    AND  ffvv.FLEX_VALUE_SET_ID = ffv.FLEX_VALUE_SET_ID 
                    AND  ID_FLEX_NUM = (SELECT id_flex_num FROM FND_ID_FLEX_STRUCTURES_VL WHERE application_id = 401 AND id_flex_code = 'MCAT' AND id_flex_structure_code = 'GM_ZZ_CAT_MERCADEO_' || hc.hierarchy_code) 
                    AND fifsv.SEGMENT_NUM = 30 
                    AND  ffvv.FLEX_VALUE_MEANING = mc.SEGMENT3
                    AND  FLEX_VALUE_SET_NAME LIKE 'GM_ZZ_CAT_MERCADEO_'||substr(hc.hierarchy_code,1,4) ||'%_' || substr(replace(fifsv.segment_name, ' ', '_'), 1, 10)
                    AND ROWNUM = 1
                  ) AS SUBNEGOCIO
                ,(SELECT  NVL( ffvv.description, ffvv.FLEX_VALUE_meaning ) nombre 
                  FROM FND_ID_FLEX_SEGMENTS_VL fifsv
                    , FND_FLEX_VALUE_SETS ffv
                    , FND_FLEX_VALUES_VL ffvv 
                  WHERE APPLICATION_ID = 401 
                    AND  ffvv.FLEX_VALUE_SET_ID = ffv.FLEX_VALUE_SET_ID 
                    AND  ID_FLEX_NUM = (SELECT id_flex_num FROM FND_ID_FLEX_STRUCTURES_VL WHERE application_id = 401 AND id_flex_code = 'MCAT' AND id_flex_structure_code = 'GM_ZZ_CAT_MERCADEO_' || hc.hierarchy_code) 
                    AND fifsv.SEGMENT_NUM = 40 
                    AND  ffvv.FLEX_VALUE_MEANING = mc.SEGMENT4
                    AND  FLEX_VALUE_SET_NAME LIKE 'GM_ZZ_CAT_MERCADEO_'||substr(hc.hierarchy_code,1,4) ||'%_' || substr(replace(fifsv.segment_name, ' ', '_'), 1, 10)
                    AND ROWNUM = 1

                  ) AS LINEA
                ,(SELECT  NVL( ffvv.description, ffvv.FLEX_VALUE_meaning ) nombre 
                  FROM FND_ID_FLEX_SEGMENTS_VL fifsv
                    , FND_FLEX_VALUE_SETS ffv
                    , FND_FLEX_VALUES_VL ffvv 
                  WHERE APPLICATION_ID = 401 
                    AND  ffvv.FLEX_VALUE_SET_ID = ffv.FLEX_VALUE_SET_ID 
                    AND  ID_FLEX_NUM = (SELECT id_flex_num FROM FND_ID_FLEX_STRUCTURES_VL WHERE application_id = 401 AND id_flex_code = 'MCAT' AND id_flex_structure_code = 'GM_ZZ_CAT_MERCADEO_' || hc.hierarchy_code) 
                    AND fifsv.SEGMENT_NUM = 50 
                    AND  ffvv.FLEX_VALUE_MEANING = mc.SEGMENT5
                    AND  FLEX_VALUE_SET_NAME LIKE 'GM_ZZ_CAT_MERCADEO_'||substr(hc.hierarchy_code,1,4) ||'%_' || substr(replace(fifsv.segment_name, ' ', '_'), 1, 10)
                   AND ROWNUM = 1
                  ) AS SUBLINEA
                ,(SELECT  NVL( ffvv.description, ffvv.FLEX_VALUE_meaning ) nombre 
                  FROM FND_ID_FLEX_SEGMENTS_VL fifsv
                    , FND_FLEX_VALUE_SETS ffv
                    , FND_FLEX_VALUES_VL ffvv 
                  WHERE APPLICATION_ID = 401 
                    AND  ffvv.FLEX_VALUE_SET_ID = ffv.FLEX_VALUE_SET_ID 
                    AND  ID_FLEX_NUM = (SELECT id_flex_num FROM FND_ID_FLEX_STRUCTURES_VL WHERE application_id = 401 AND id_flex_code = 'MCAT' AND id_flex_structure_code = 'GM_ZZ_CAT_MERCADEO_' || hc.hierarchy_code) 
                    AND fifsv.SEGMENT_NUM = 60 
                    AND  ffvv.FLEX_VALUE_MEANING = mc.SEGMENT6
                    AND  FLEX_VALUE_SET_NAME LIKE 'GM_ZZ_CAT_MERCADEO_'||substr(hc.hierarchy_code,1,4) ||'%_' || substr(replace(fifsv.segment_name, ' ', '_'), 1, 10)
                    AND ROWNUM = 1
                  ) AS MARCA
                ,(SELECT  NVL( ffvv.description, ffvv.FLEX_VALUE_meaning ) nombre 
                  FROM FND_ID_FLEX_SEGMENTS_VL fifsv
                    , FND_FLEX_VALUE_SETS ffv
                    , FND_FLEX_VALUES_VL ffvv 
                  WHERE APPLICATION_ID = 401 
                    AND  ffvv.FLEX_VALUE_SET_ID = ffv.FLEX_VALUE_SET_ID 
                    AND  ID_FLEX_NUM = (SELECT id_flex_num FROM FND_ID_FLEX_STRUCTURES_VL WHERE application_id = 401 AND id_flex_code = 'MCAT' AND id_flex_structure_code = 'GM_ZZ_CAT_MERCADEO_' || hc.hierarchy_code) 
                    AND fifsv.SEGMENT_NUM = 70 
                    AND  ffvv.FLEX_VALUE_MEANING = mc.SEGMENT7
                    AND  FLEX_VALUE_SET_NAME LIKE 'GM_ZZ_CAT_MERCADEO_'||substr(hc.hierarchy_code,1,4) ||'%_' || substr(replace(fifsv.segment_name, ' ', '_'), 1, 10)
                    AND ROWNUM = 1
                  ) AS FAMILIA
                   ,msi.INVENTORY_ITEM_ID
                   ,mc.SEGMENT1 COD_UEN
                   ,mc.SEGMENT2 COD_MARCA_CORPORATIVA
                   ,mc.SEGMENT3 COD_SUBNEGOCIO
                   ,mc.SEGMENT4 COD_LINEA
                   ,mc.SEGMENT5 COD_SUBLINEA
                   ,mc.SEGMENT6 COD_MARCA
                   ,mc.SEGMENT7 COD_FAMILIA
              FROM  MTL_ITEM_CATEGORIES mic
                   ,MTL_CATEGORIES mc
                   /*,(SELECT XXMU_DEV_HIERARCHY_CODE() AS HIERARCHY_CODE
                       FROM DUAL
                    )hc
                    --SELECT * --id_flex_structure_code
                    --FROM FND_ID_FLEX_STRUCTURES_VL 
                    --WHERE application_id = 401 
                    --AND id_flex_code = 'MCAT' 
                    --AND id_flex_structure_code LIKE 'GM_ZZ_CAT_MERCADEO_%'
                    */
                   ,(SELECT hierarchy_code
                       FROM  (SELECT  'PINTURAS' AS HIERARCHY_CODE
                                FROM  DUAL
                                   UNION ALL
                              SELECT  'QUIMICO' AS HIERARCHY_CODE
                                FROM  DUAL
                                   UNION ALL
                              SELECT  'AGUAS' AS HIERARCHY_CODE
                                FROM  DUAL
                                   UNION ALL
                              SELECT  'TINTAS' AS HIERARCHY_CODE
                                FROM  DUAL
                                   UNION ALL
                              SELECT  'ENVASES' AS HIERARCHY_CODE
                                FROM  DUAL
                                   UNION ALL
                              SELECT  'COMERCIO' AS HIERARCHY_CODE
                                FROM  DUAL                        
                            ) HIERARCHIES
                       WHERE hierarchies.hierarchy_code = 'COMERCIO'
                    ) Hc   
                   ,mtl_system_items_b msi  
              WHERE mic.CATEGORY_ID = mc.CATEGORY_ID
                AND mic.ORGANIZATION_ID = (SELECT ORGANIZATION_ID FROM MTL_PARAMETERS WHERE ORGANIZATION_CODE = '0MA')
                AND mic.CATEGORY_SET_ID = ( SELECT category_set_id
                                              FROM MTL_CATEGORY_SETS_B
                                             WHERE structure_id = ( SELECT id_flex_num
                                                                    FROM FND_ID_FLEX_STRUCTURES_VL
                                                                    WHERE application_id = 401
                                                                      AND id_flex_code = 'MCAT'
                                                                      AND id_flex_structure_code = 'GM_ZZ_CAT_MERCADEO_' || hc.hierarchy_code
                                                                  )
                                          )
                AND msi.inventory_item_id = mic.inventory_item_id
                AND msi.organization_id = 107 --OMA
                AND msi.segment1 = NVL(&p_articulo, msi.segment1)
                --AND ROWNUM <= 5
                ;
