with vendas as (
  select *
  from {{ ref('stg_vendas') }}
),
usuarios as (
  select *
  from {{ ref('stg_usuarios') }}
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
  receita_total desc;


