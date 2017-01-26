SELECT  *
  FROM  (SELECT xpa.person_id
               ,xpa.assignment_id
               ,xpa.payroll_id
               ,xpa.organization_id
               ,MAX(xpe.effective_start_date) AS max_emp_start_date               
               ,MAX(xpe.effective_end_date) AS max_emp_end_date
               ,MAX(xpa.effective_start_date) AS max_ass_start_date
               ,MAX(xpa.effective_end_date) AS max_ass_end_date
          FROM  xxmu_pay_assignments_v xpa
               ,xxmu_pay_employees_v xpe
         WHERE  1 = 1
           --AND  xpe.employee_type IN ('Empleado', 'Jubilado')
           AND  xpa.effective_start_date < TO_DATE(EXTRACT(YEAR FROM SYSDATE) || '1231', 'YYYYMMDD')
           AND  xpe.person_id = xpa.person_id
           AND  xpe.effective_start_date < TO_DATE(EXTRACT(YEAR FROM SYSDATE) || '1231', 'YYYYMMDD')
           AND  xxmu_pay_utils_pkg.overlaps_dates( TO_DATE(&P_YEAR||'0101', 'YYYYMMDD')
                                                  ,TO_DATE(&P_YEAR||'1231', 'YYYYMMDD')
                                                  ,xpa.effective_start_date
                                                  ,xpa.effective_end_date) = 'Y'
        GROUP BY xpa.person_id, xpa.assignment_id, xpa.payroll_id, xpa.organization_id
        ) emp
       ,xxmu_pay_payrolls_info_v xpi
WHERE   1 = 1
  AND   xpi.legal_entity_id = &P_LEGAL_ENTITY_ID
  AND   emp.payroll_id = xpi.payroll_id
    ;
