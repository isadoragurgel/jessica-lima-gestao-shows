# Publicação na main — ler antes

Este ZIP inclui os ajustes mobile, despesas conjuntas, relatórios e um seletor de moeda + inclusão no património do casal para o saldo inicial do perfil.

**Obrigatório para usar o novo seletor:** aplicar a migração `SQL-OPCIONAL-INVESTIMENTOS.sql` após backup recuperável. Sem a migração, a aplicação continua a carregar os dados, mas a gravação de saldos de perfil com os novos campos falhará.

Não foi executada nenhuma alteração no banco. Não foi feito deploy.

Todos os saldos antigos permanecem EUR e incluídos no total por padrão. Aportes e resgates continuam em EUR; NÃO registe aportes noutra moeda como se fossem euros.

Desmarcar o toggle remove o saldo inicial do total do casal; não oculta os dados do parceiro. Não representa separação jurídica de propriedade.

Os totais de investimentos em EUR incluem aportes/resgates legados; moedas estrangeiras são mostradas por saldo, sem conversão.

O Preview da Vercel e a main podem usar o mesmo Supabase. Não usar dados reais para testes.

Teste em dois perfis, especialmente as despesas conjuntas e a consistência dos totais, antes de confiar na versão em produção.
