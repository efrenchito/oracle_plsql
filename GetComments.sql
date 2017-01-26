select   
  decode(column_id,0,TABLE_NAME,null) as TABLE_NAME,  
  decode(column_id,0,null,column_id)  as COLUMN_ID,  
  COLUMN_NAME, NULLABLE, DATA_TYPE, COMMENTS  
from (  
  select cc.TABLE_NAME,  
    tc.COLUMN_ID, tc.COLUMN_NAME,  
    tc.NULLABLE, tc.DATA_TYPE ||   
      case when tc.DATA_SCALE is not null then '(' || tc.DATA_PRECISION || ',' || tc.DATA_SCALE || ')'  
        when tc.DATA_PRECISION is not null then '(' || tc.DATA_PRECISION || ')'  
        when tc.DATA_LENGTH is not null and tc.DATA_TYPE like '%CHAR%' then '(' || tc.DATA_LENGTH || ')'  
      end DATA_TYPE,  
    cc.COMMENTS  
  from all_col_comments cc
  INNER JOIN all_tab_cols tc ON (cc.TABLE_NAME = tc.TABLE_NAME and cc.TABLE_NAME = tc.TABLE_NAME and cc.COLUMN_NAME = tc.COLUMN_NAME)   
  UNION  
  select tab.table_name as TABLE_NAME,   
         0 as COLUMN_ID, '' as COLUMN_NAME,  
         '' as NULLABLE, '' as DATA_TYPE,  
         tab.comments as COMMENTS  
  from all_tab_comments tab  
)   
WHERE table_name LIKE 'XXOCS_HCM_HRT_CNT_ITEMS_TL' --'XXOCS_HCM_HRT_CNT_ITEMS_B' --'XXOCS_HCM_ORG_UNIT_CLASS_F' --'XXOCS_HCM_ORG_UNITS_F' --'XXOCS_HCM_ORG_INFO_F'
ORDER BY table_name, TO_NUMBER(column_id) ; 
