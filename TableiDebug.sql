CREATE TABLE iDebug(tag VARCHAR2(150), text VARCHAR2(450), creation_date DATE);
INSERT INTO iDebug VALUES('INSERT', 'Testing...', SYSDATE);
COMMIT;

SELECT * FROM iDebug;


