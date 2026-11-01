# Fase 3 — Mês previsto de recebimento

1. No Supabase, SQL Editor, execute `FASE-3-SUPABASE.sql` antes de publicar.
2. Extraia o ZIP e envie os arquivos para a raiz da branch main no GitHub.
3. Abra uma gig, confirme o mês preenchido automaticamente e altere apenas se necessário.
4. Salve e confira em outro dispositivo se o mês personalizado permanece.

Regras: semanal +7 dias, quinzenal +15 dias, mensal +30 dias; Cash in hand usa o mês da gig como previsão inicial. O mês personalizado é salvo na coluna `expected_receipt_month` de `jl_gigs` e não altera a data da apresentação.

**Limitação importante:** esta versão adiciona a previsão individual persistida na Agenda, mas NÃO implementa o lançamento automático de receitas previstas no Meu Controle, nem a conciliação com `mc_transactions`. Não trate esta versão como integração financeira concluída.
