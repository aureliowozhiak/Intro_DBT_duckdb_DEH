
  
    
    

    create  table
      "curso_dbt_duckdb"."main"."01_hello_world__dbt_tmp"
  
    as (
      select
  'Hello dbt + DuckDB' as message,
  current_timestamp as created_at
    );
  
  