CREATE TABLE xxmu_pay_forms
(
   formula_name VARCHAR2(80)
  ,formula_text CLOB 
);
-----
TRUNCATE TABLE xxmu_pay_forms;
-----
INSERT INTO xxmu_pay_forms --xxmu_pay_forms_1 --xxmu_pay_forms_2
SELECT F.FORMULA_NAME
      ,F.FORMULA_TEXT
FROM   FF_FORMULAS_F@DBLINK_TO_TST110.GRUPOMUN.COM F
--FROM   XXMU_PAY_FORMULA F
WHERE  1 = 1
;
--AND    F.FORMULA_NAME LIKE 'HN_%';
COMMIT;

SELECT * 
FROM   xxmu_pay_forms XPF
      --,xxmu_pay_forms XPF2
WHERE  1 = 1
/*
AND    XPF.FORMULA_TEXT LIKE '%GET_GM_VE_DATOS_VENEZUELA%'
AND    xpf.formula_name = xpf2.formula_name
AND    xpf.formula_text LIKE xpf2.formula_text
AND    xpf.formula_name IN ('VE_A_0340', 'VE_D_2400', 'VE_D_2423')
AND    xpf2.formula_name IN ('VE_D_2400', 'VE_D_2423')
*/
AND    xpf.formula_text LIKE '%HN_BASE_REGIMEN_APORTACIONE%'
;

SELECT *
FROM   XXMU_PAY_FORMULA
;
