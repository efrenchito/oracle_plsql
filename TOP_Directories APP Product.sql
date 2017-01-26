SELECT variable_name,
       VALUE
  FROM apps.fnd_env_context
 WHERE variable_name LIKE '%\_TOP' ESCAPE '\'
   AND concurrent_process_id =
       (SELECT MAX(concurrent_process_id)         
              FROM apps.fnd_env_context)
 ORDER BY 1;
