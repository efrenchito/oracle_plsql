SELECT SID, OWNER, OBJECT, TYPE
  FROM V$ACCESS
 WHERE OBJECT LIKE 'XXOCS_AP_INVOICES_PKG';

SELECT a.object_id, a.session_id, substr(b.object_name, 1, 40)
FROM v$locked_object a, dba_objects b
WHERE a.object_id = b.object_id
AND b.object_name like 'XXOCS_AP_INVOICES_PKG'
ORDER BY b.object_name;

SELECT l.*, o.owner object_owner, o.object_name
FROM SYS.all_objects o, v$lock l
WHERE 1 = 1 --l.TYPE = 'TM'
AND o.object_id = l.id1
AND o.object_name in 'XXOCS_AP_INVOICES_PKG'
;

SELECT SID, SERIAL#
FROM v$session
WHERE SID = 273;

ALTER SYSTEM KILL SESSION '273,24723' IMMEDIATE;



--Tools>Sessions...  Kill
----------------------------------------------
SELECT SID, SERIAL#
FROM V$SESSION
WHERE USERNAME = 

 
ALTER SYSTEM KILL SESSION '7,15';
----------------------------------------------
select substr(a.os_user_name,1,8) "OS User"
, substr(b.object_name,1,30) "Object Name"
, substr(b.object_type,1,8) "Type"
, substr(c.segment_name,1,10) "RBS"
, e.process "PROCESS"
, substr(d.used_urec,1,8) "# of Records"
, e.sid
, e.serial#
, p.*
from v$locked_object a
, dba_objects b
, dba_rollback_segs c
, v$transaction d
, v$session e
, v$process p
where a.object_id = b.object_id
and a.xidusn = c.segment_id
and a.xidusn = d.xidusn
and a.xidslot = d.xidslot
and d.addr = e.taddr
and p.addr = e.paddr;

ALTER SYSTEM DISCONNECT SESSION '873, 56205' IMMEDIATE;
<sid of 1>, <serial# of 1>
;

-----[GLOBAL TEMPORARY TABLE]
SELECT s.username
      ,s.sid 
      ,S.SERIAL# AS SERIAL 
      , s.inst_id 
FROM gv$lock l
,dba_objects o
,gv$session s
WHERE l.id1 = o.object_id
AND s.sid = l.sid
--AND o.owner = 'GG'
AND o.object_name = 'XXAVT_IRC_RECRUITMENT_CONTEXT'
;

-----
SELECT
decode(L.TYPE,'TM','TABLE','TX','Record(s)') TYPE_LOCK,
decode(L.REQUEST,0,'NO','YES') WAIT,
S.OSUSER OSUSER_LOCKER,
S.PROCESS PROCESS_LOCKER,
S.USERNAME DBUSER_LOCKER,
O.OBJECT_NAME OBJECT_NAME,
O.OBJECT_TYPE OBJECT_TYPE,
concat(' ',s.PROGRAM) PROGRAM,
O.OWNER OWNER
FROM v$lock l,dba_objects o,v$session s
WHERE l.ID1 = o.OBJECT_ID
AND s.SID =l.SID
AND l.TYPE in ('TM','TX');
