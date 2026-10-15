-- SOMENTE LEITURA. Não altera, recria nem transfere dados.
select g.id as gig_id, v.name as local, g.performance_date as data,
       g.start_time as inicio, g.status, g.gross_fee as cache_bruto,
       g.musician_amount as cache_musico,
       coalesce((select sum(t.amount) from public.jl_tips t where t.gig_id=g.id),0) as tips,
       coalesce((select sum(r.amount) from public.jl_gig_receipts r where r.gig_id=g.id),0) as recebido_agencia,
       coalesce((select sum(p.amount) from public.jl_musician_payments p where p.gig_id=g.id),0) as repasse_musico
from public.jl_gigs g
join public.jl_venues v on v.id=g.venue_id and v.artist_id=g.artist_id
where g.performance_date between date '2026-10-14' and date '2026-10-15'
order by g.performance_date,v.name,g.start_time;
