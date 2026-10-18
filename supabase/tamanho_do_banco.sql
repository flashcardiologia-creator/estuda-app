-- Quanto o banco e os arquivos ocupam, comparado com os limites do plano Free do Supabase.
-- Só consulta (não altera nada). Rode no SQL Editor; o resultado é uma tabela única.
--   * Banco de dados: limite de 500 MB no plano Free.
--   * Arquivos (Storage, onde ficam as imagens): limite de 1 GB no plano Free.
-- O tráfego de saída (egress, 5 GB por mês) não aparece aqui: veja em Settings > Usage no painel.

with total as (
  select 1 as ord,
         'BANCO DE DADOS (total)' as item,
         pg_database_size(current_database()) as bytes,
         500::numeric * 1024 * 1024 as limite
),
tabelas as (
  select 2 as ord,
         '  tabela ' || n.nspname || '.' || c.relname as item,
         pg_total_relation_size(c.oid) as bytes,
         null::numeric as limite
  from pg_class c
  join pg_namespace n on n.oid = c.relnamespace
  where c.relkind = 'r'
    and n.nspname not in ('pg_catalog', 'information_schema')
  order by pg_total_relation_size(c.oid) desc
  limit 15
),
arquivos as (
  select 3 as ord,
         'ARQUIVOS (Storage, total)' as item,
         coalesce(sum((o.metadata ->> 'size')::bigint), 0) as bytes,
         1024::numeric * 1024 * 1024 as limite
  from storage.objects o
),
por_bucket as (
  select 4 as ord,
         '  bucket ' || o.bucket_id as item,
         coalesce(sum((o.metadata ->> 'size')::bigint), 0) as bytes,
         null::numeric as limite
  from storage.objects o
  group by o.bucket_id
)
select item,
       pg_size_pretty(bytes::bigint) as tamanho,
       case when limite is not null then round(bytes / limite * 100, 1)::text || ' % do limite' else '' end as uso_do_limite
from (
  select * from total
  union all select * from tabelas
  union all select * from arquivos
  union all select * from por_bucket
) t
order by ord, bytes desc;
