SELECT * FROM v$instance;

SELECT pap.person_id, paa.assignment_id, pap.full_name, ppp.attribute1
FROM   PER_PAY_PROPOSALS ppp
      ,per_all_assignments_f paa
      ,per_all_people_f pap
WHERE  1 = 1
AND    SYSDATE BETWEEN ppp.change_date AND NVL(ppp.date_to, SYSDATE +1)
AND    ppp.assignment_id = paa.assignment_id
AND    sysdate BETWEEN paa.effective_start_date AND paa.effective_end_date
--AND    ppp.proposed_salary IS NOT NULL
AND    pap.person_id = paa.person_id
AND    SYSDATE BETWEEN pap.effective_start_date AND pap.effective_end_date
AND    ppp.attribute1 IS NOT NULL
AND    pap.full_name LIKE '%&p_full_Name%'
;
