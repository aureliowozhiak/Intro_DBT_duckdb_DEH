
  
    
    

    create  table
      "curso_dbt_duckdb"."main"."stg_usuarios__dbt_tmp"
  
    as (
      select
  cast(id as integer)        as usuario_id,
  nome,
  email,
  cast(created_at as timestamp) as created_at
from "curso_dbt_duckdb"."main"."usuarios"
where email is not null
    );
  
  