--CREATE OR REPLACE VIEW XXMU_PAY_CALENDAR
SELECT  *
  FROM  (SELECT  /*+ INDEX(C PAY_USER_COLUMNS_FK1)
                    INDEX(R PAY_USER_ROWS_F_FK1)
                    INDEX(CINST PAY_USER_COLUMN_INSTANCES_N1)
                    ORDERED */
                tab.user_table_Name AS TABLE_NAME
               ,c.business_group_id 
               ,c.legislation_code
               ,c.user_column_name AS COLUMN_NAME
               ,r.effective_start_date
               ,r.effective_end_date
               ,to_date(r.row_low_range_or_name, 'YYYY/MM/DD HH24:MI:SS') AS FECHA
               --,r.row_low_range_or_name FECHA
               ,CINST.value AS CLASIFICACION
         FROM   pay_user_tables tab
               ,pay_user_columns C
               ,pay_user_rows_f R
               ,pay_user_column_instances_f CINST
        WHERE   1 = 1         
          --AND   TAB.user_table_id = l_table_id  
          AND   C.user_table_id = TAB.user_table_id
          --AND   NVL(C.business_group_id,NVL(&p_bus_group_id, -1)) = NVL(&p_bus_group_id, -1)
          --AND   NVL(C.legislation_code,NVL(&g_leg_code, '#N/A')) = NVL(&g_leg_code, '#N/A')
          --AND   UPPER(C.user_column_name) = upper (&p_col_name)

          AND   R.user_table_id  = C.user_table_id
          --AND   l_effective_date between R.effective_start_date and     R.effective_end_date
          --AND   NVL(R.business_group_id, NVL(&p_bus_group_id, -1)) = NVL(&p_bus_group_id, -1)
          AND   NVL(R.business_group_id, NVL(C.business_group_id, -1)) = NVL(C.business_group_id, -1)
          --AND   NVL(R.legislation_code,NVL(&g_leg_code, '#N/A'))  = NVL(&g_leg_code, '#N/A')
          AND   NVL(R.legislation_code,NVL(C.legislation_code, '#N/A'))  = NVL(C.legislation_code, '#N/A')
          /*AND   DECODE(TAB.user_key_units,
                       'D', to_char(fnd_date.canonical_to_date(p_row_value)),
                       'N', to_char(fnd_number.canonical_to_number(p_row_value)),
                       'T', upper (p_row_value),
                       null) =  DECODE(TAB.user_key_units,
                                       'D', to_char(fnd_date.canonical_to_date(R.row_low_range_or_name)),
                                       'N', to_char(fnd_number.canonical_to_number(R.row_low_range_or_name)),
                                       'T', UPPER(R.row_low_range_or_name),
                                       null)*/

        AND    CINST.user_column_id = C.user_column_id
        AND    CINST.user_row_id = R.user_row_id
        --AND    l_effective_date between CINST.effective_start_date and CINST.effective_end_date
        --AND    nvl (CINST.business_group_id,NVL(&p_bus_group_id, -1)) = NVL(&p_bus_group_id, -1)
        AND    nvl (CINST.business_group_id,NVL(C.business_group_id, -1)) = NVL(C.business_group_id, -1)
        --AND    nvl (CINST.legislation_code,NVL(&g_leg_code, '#N/A')) = NVL(&g_leg_code, '#N/A')
        AND    nvl (CINST.legislation_code,NVL(C.legislation_code, '#N/A')) = NVL(C.legislation_code, '#N/A')
        ) GM_CALENDARIO
        -----
        WHERE  1 = 1
        AND    GM_CALENDARIO.TABLE_NAME = 'CO_CALENDARIO'
        AND    GM_CALENDARIO.COLUMN_NAME = 'FECHA'
        AND    GM_CALENDARIO.FECHA BETWEEN TO_DATE('2013/06/01', 'YYYY/MM/DD') 
                                       AND TO_DATE('2013/06/30', 'YYYY/MM/DD')
        ;
