--Supongamos una tabla donde se guarde el total de las ventas mensuales por distintas compañías:
DROP TABLE test_transpuesta;
CREATE TABLE test_transpuesta (
  company   varchar(12),
  monthy    char(7),
  sales     number
);

INSERT INTO test_transpuesta VALUES ('CMP1','2008-06', 10);
INSERT INTO test_transpuesta VALUES ('CMP1','2008-07', 29);
INSERT INTO test_transpuesta VALUES ('CMP1','2008-08', 39);
INSERT INTO test_transpuesta VALUES ('CMP1','2008-09', 41);
INSERT INTO test_transpuesta VALUES ('CMP1','2008-10', 22);

INSERT INTO test_transpuesta VALUES ('CMP2','2008-06', 13);
INSERT INTO test_transpuesta VALUES ('CMP2','2008-07', 17);
INSERT INTO test_transpuesta VALUES ('CMP2','2008-08', 61);
INSERT INTO test_transpuesta VALUES ('CMP2','2008-09', 55);
INSERT INTO test_transpuesta VALUES ('CMP2','2008-10', 71);

INSERT INTO test_transpuesta VALUES ('CMP3','2008-06', 33);
INSERT INTO test_transpuesta VALUES ('CMP3','2008-07', 18);
INSERT INTO test_transpuesta VALUES ('CMP3','2008-08', 27);
INSERT INTO test_transpuesta VALUES ('CMP3','2008-09',  5);
INSERT INTO test_transpuesta VALUES ('CMP3','2008-10', 32);

SELECT * FROM test_transpuesta;

--Para obtener lo totales de ventas por compañía, podemos escribir algo así:
  SELECT    company, monthy,SUM(sales)
    FROM    test_transpuesta
GROUP BY    company, monthy;

--Si nuestra intención es disponer estos datos de forma traspuesta, y obtener un listado donde:
--Cada fila represente una compañía
--Cada columna represente un valor los meses totalizados
--podemos escribir algo así:


  SELECT  company,jul,ago,sep,oct
    FROM  (  SELECT  company
                    ,SUM(case when monthy='2008-07' then sales else NULL end) jul
                    ,SUM(case when monthy='2008-08' then sales else NULL end) ago
                    ,SUM(case when monthy='2008-09' then sales else NULL end) sep
                    ,SUM(case when monthy='2008-10' then sales else NULL end) oct
               FROM  test_transpuesta
           GROUP BY  company );

--Donde obtendríamos:
/*
company      jul        ago        sep        oct    
-------- ---------- ---------- ---------- ---------- 
CMP1         29         39         41         22
CMP2         17         61         55         71    
CMP3         18         27          5         32
*/

--Si bien, la consulta anterior funciona, no es muy intuitiva. 
--Con la cláusula PIVOT podemos escribir la misma consulta de manera más sencilla y entendible:
  SELECT  *
    FROM  test_transpuesta
       /*( SELECT  company, monthy, sales
             FROM  test_transpuesta       ) S*/
   PIVOT (SUM(sales) FOR monthy IN ('2008-07','2008-08','2008-09', '2008-10'))
ORDER BY    company;

--Esto es solo un comienzo, dejo a vuestra imaginación y uso todas las combinaciones posibles que podemos escribir 
--con esta cláusula.
