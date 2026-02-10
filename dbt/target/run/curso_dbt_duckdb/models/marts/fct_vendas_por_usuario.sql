
  
    
    

    create  table
      "curso_dbt_duckdb"."main"."fct_vendas_por_usuario__dbt_tmp"
  
    as (
      with vendas as (
  select *
  from "curso_dbt_duckdb"."main"."stg_vendas"
),
usuarios as (
  select *
  from "curso_dbt_duckdb"."main"."stg_usuarios"
)

select
  u.usuario_id,
  u.nome,
  count(v.venda_id)        as total_vendas,
  sum(v.valor)             as receita_total,
  min(v.data_venda)        as primeira_venda,
  max(v.data_venda)        as ultima_venda
from usuarios u
left join vendas v
  on u.usuario_id = v.usuario_id
group by
  u.usuario_id,
  u.nome
order by
  receita_total desc
    );
  
  