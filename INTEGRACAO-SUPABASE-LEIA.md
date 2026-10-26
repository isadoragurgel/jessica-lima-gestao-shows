# Meu Controle — Integração Supabase (versão de teste)

Este pacote troca o armazenamento local do Financeiro pelas tabelas `mc_accounts`, `mc_categories`, `mc_transactions`, `mc_shared_expenses` e `mc_settlements`. As gigs e invoices continuam no código original. DAY OFF permanece com a sincronização anterior.

**Teste primeiro na branch `teste-melhorias`.** Ainda não foi possível testar uma sessão real do seu Supabase ou confirmar as políticas RLS de SELECT/INSERT/UPDATE/DELETE. Se o banco bloquear operações, a interface exibirá o erro; não considerará a operação salva.

**Verificações manuais:** faça login; crie uma despesa e uma categoria; atualize; confira em outro dispositivo; marque e liquide um acerto; teste Cash in hand e Tips como receitas manuais; confira saldos e exportação. Não coloque a versão na `main` antes desses testes.

**Atenção:** Cash in hand/Tips automáticos derivados de gigs não são importados automaticamente neste pacote. É possível lançar manualmente como receita; não duplique os valores de gigs que já foram contabilizados. Não houve migração de dados locais.
