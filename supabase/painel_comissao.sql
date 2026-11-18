-- Painel de dados, aba COMISSÃO: resumo geral e resumo de cada pessoa que convidou amigos (convite por pontos).
-- Rode DEPOIS do convite_pontos.sql. Seguro para rodar de novo. Só lê dados: não muda nenhuma tabela.
--
-- public.admin_comissoes(): confere o e-mail da administradora no banco (qualquer outra conta recebe "forbidden") e devolve
--   geral   = totais do programa: convites, quantos assinaram, pontos ganhos, aguardando os 7 dias, liberados, já sacados,
--             quanto há para pagar agora e quantas pessoas já podem sacar (250 pontos ou mais). 1 ponto = R$ 1,00.
--   pessoas = uma linha por pessoa que convidou alguém, com os números dela, os últimos convidados, os saques já pagos e o
--             último pedido de saque feito pela aba Contato (mensagem que começa com SOLICITAÇÃO DE COMISSÃO, com a chave PIX).
--
-- Para pagar um saque: pague o PIX e registre com  select public.admin_registrar_saque('email', pontos);  (convite_pontos.sql).

create or replace function public.admin_comissoes()
returns jsonb
language plpgsql
stable
security definer
set search_path = public, auth
as $$
declare
  v_email   text;
  v_pedidos jsonb := '{}'::jsonb;
begin
  select lower(u.email) into v_email from auth.users u where u.id = auth.uid();
  if v_email is null or not (v_email = any (array['flashcardiologia@gmail.com'])) then
    raise exception 'forbidden';
  end if;

  -- Último pedido de saque de cada pessoa (mensagens do Contato). Se a tabela ou a coluna de data não existir, segue sem os pedidos.
  begin
    execute $q$
      select coalesce(jsonb_object_agg(q.user_id::text, jsonb_build_object('mensagem', q.msg, 'em', q.em)), '{}'::jsonb)
        from (select distinct on (c.user_id) c.user_id, left(c.mensagem, 600) as msg, to_jsonb(c) ->> 'created_at' as em
                from public.contact_messages c
               where c.mensagem ilike 'SOLICITAÇÃO DE COMISSÃO%'
               order by c.user_id, to_jsonb(c) ->> 'created_at' desc nulls last) q
    $q$ into v_pedidos;
  exception when others then
    v_pedidos := '{}'::jsonb;
  end;

  return (
    with por_pessoa as (
      select r.inviter_id as id,
             count(*) as convidados,
             count(*) filter (where r.status = 'premiado') as assinaram,
             count(*) filter (where r.status = 'revertido') as estornados,
             coalesce(sum(r.reward_points) filter (where r.status = 'premiado'), 0) as ganhos,
             coalesce(sum(r.reward_points) filter (where r.status = 'premiado' and r.release_at > now()), 0) as aguardando,
             coalesce(sum(r.reward_points) filter (where r.status = 'premiado' and r.release_at <= now()), 0) as liberados_brutos,
             max(r.created_at) as ultimo_convite
        from public.referrals r
       group by r.inviter_id
    ),
    saques as (
      select w.user_id, sum(w.points) as sacados, max(w.created_at) as ultimo_saque, count(*) as qtd
        from public.referral_withdrawals w
       group by w.user_id
    ),
    pp as (
      select p.id,
             coalesce(nullif(btrim(pr.name), ''), '(sem nome)') as nome,
             u.email,
             pr.friend_code as codigo,
             p.convidados, p.assinaram, p.estornados, p.ganhos, p.aguardando,
             coalesce(s.sacados, 0) as sacados,
             coalesce(s.qtd, 0) as saques_qtd,
             s.ultimo_saque,
             greatest(0, p.liberados_brutos - coalesce(s.sacados, 0)) as saldo,
             p.ultimo_convite
        from por_pessoa p
        left join public.profiles pr on pr.id = p.id
        left join auth.users u on u.id = p.id
        left join saques s on s.user_id = p.id
    )
    select jsonb_build_object(
      'gerado_em', now(),
      'geral', jsonb_build_object(
        'convites', (select count(*) from public.referrals),
        'assinaram', (select count(*) from public.referrals where status = 'premiado'),
        'estornados', (select count(*) from public.referrals where status = 'revertido'),
        'mensal', (select count(*) from public.referrals where status = 'premiado' and reward_plan = 'mensal' and reward_points is not null),
        'anual', (select count(*) from public.referrals where status = 'premiado' and reward_plan = 'anual' and reward_points is not null),
        'pessoas', (select count(*) from pp),
        'pontos_ganhos', coalesce((select sum(ganhos) from pp), 0),
        'aguardando', coalesce((select sum(aguardando) from pp), 0),
        'sacados', coalesce((select sum(sacados) from pp), 0),
        'a_pagar', coalesce((select sum(saldo) from pp), 0),
        'podem_sacar_qtd', (select count(*) from pp where saldo >= 250),
        'podem_sacar_valor', coalesce((select sum(saldo) from pp where saldo >= 250), 0),
        'saques_qtd', coalesce((select sum(saques_qtd) from pp), 0),
        'pedidos_qtd', (select count(*) from jsonb_object_keys(v_pedidos))
      ),
      'pessoas', coalesce((
        select jsonb_agg(jsonb_build_object(
                 'id', pp.id, 'nome', pp.nome, 'email', pp.email, 'codigo', pp.codigo,
                 'convidados', pp.convidados, 'assinaram', pp.assinaram, 'estornados', pp.estornados,
                 'ganhos', pp.ganhos, 'aguardando', pp.aguardando, 'sacados', pp.sacados, 'saldo', pp.saldo,
                 'pode_sacar', pp.saldo >= 250, 'saques_qtd', pp.saques_qtd,
                 'ultimo_convite', pp.ultimo_convite, 'ultimo_saque', pp.ultimo_saque,
                 'pedido', v_pedidos -> (pp.id::text),
                 'convites', coalesce((
                   select jsonb_agg(jsonb_build_object(
                            'nome', coalesce(nullif(btrim(ip.name), ''), 'Amigo'),
                            'email', iu.email,
                            'plano', x.reward_plan,
                            'status', x.status,
                            'pontos', x.reward_points,
                            'liberado', (x.status = 'premiado' and coalesce(x.release_at <= now(), true)),
                            'liberar_em', x.release_at,
                            'em', coalesce(x.rewarded_at, x.created_at)
                          ) order by x.created_at desc)
                     from (select * from public.referrals where inviter_id = pp.id order by created_at desc limit 30) x
                     left join public.profiles ip on ip.id = x.invitee_id
                     left join auth.users iu on iu.id = x.invitee_id
                 ), '[]'::jsonb),
                 'saques', coalesce((
                   select jsonb_agg(jsonb_build_object('pontos', w.points, 'em', w.created_at) order by w.created_at desc)
                     from (select * from public.referral_withdrawals where user_id = pp.id order by created_at desc limit 20) w
                 ), '[]'::jsonb)
               ) order by pp.saldo desc, pp.aguardando desc, pp.convidados desc, pp.nome)
          from (select * from pp order by saldo desc, aguardando desc, convidados desc, nome limit 300) pp
      ), '[]'::jsonb)
    )
  );
end
$$;

revoke all on function public.admin_comissoes() from public, anon;
grant execute on function public.admin_comissoes() to authenticated;
