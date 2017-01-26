SELECT ROWNUM AS NUM_COPIA
FROM   dual 
CONNECT BY ROWNUM  <= 5   
;

SELECT ROW_NUMBER() OVER(PARTITION BY ASSIGNMENT_ID 
                             ORDER BY ASSIGNMENT_ID, ELEMENT_NAME)
FROM   PER_ALL_ASSIGNMENTS_F
;

--rank over(partition by...)