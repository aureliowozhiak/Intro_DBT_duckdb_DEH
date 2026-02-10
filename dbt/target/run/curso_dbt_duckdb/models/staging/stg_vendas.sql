
  
    
    

    create  table
      "curso_dbt_duckdb"."main"."stg_vendas__dbt_tmp"
  
    as (
      select
  cast(id as integer)          as venda_id,
  cast(usuario_id as integer)  as usuario_id,
  cast(valor as double)        as valor,
  cast(data_venda as date)     as data_venda
from "curso_dbt_duckdb"."main"."vendas"
    );
  
  