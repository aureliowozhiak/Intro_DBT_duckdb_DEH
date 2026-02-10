select
  cast(id as integer)          as venda_id,
  cast(usuario_id as integer)  as usuario_id,
  cast(valor as double)        as valor,
  cast(data_venda as date)     as data_venda
from {{ ref('vendas') }}