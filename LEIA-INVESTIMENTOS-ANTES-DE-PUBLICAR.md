# Investimentos — implementação opcional e preservação dos dados

## Estado do banco

A migração `08-nos-investimentos-opcional.sql` **NÃO FOI EXECUTADA**. A aplicação não deve apresentar tela branca se as tabelas `nos_investment_balances` e `nos_investment_movements` não existirem. Nesse caso os controles de investimento ficam desativados.

## Como funciona

- Saldo disponível: saldo inicial das contas + receitas - despesas ± transferências - aportes + resgates.
- Saldo investido: saldos iniciais de investimento (pessoa 1, pessoa 2 e casal) + aportes - resgates.
- Patrimônio total: disponível + investido. Não há rendimento ou valorização automática nesta versão.
- Aporte e resgate são movimentos **separados**, não são despesas/receitas e não entram nos acertos proporcionais.
- Saldo inicial investido não altera o saldo das contas. Informe apenas o valor que já existia antes de usar o aplicativo; não duplique os aportes novos.
- Cada pessoa edita seu próprio saldo inicial em Casal → Perfil. O saldo inicial conjunto fica em Casal → Patrimônio investido.
- Aportes e resgates podem ser registrados, editados e excluídos em Movimentos → Investimentos.

## Segurança e implantação

1. Não é necessário executar SQL para **abrir** esta versão; a interface normal deve funcionar sem as tabelas novas.
2. Para **ativar a gravação** de investimentos é indispensável criar as duas tabelas novas. O SQL é aditivo, não contém DROP TABLE, TRUNCATE, DELETE ou UPDATE em tabelas financeiras existentes.
3. **Não execute a migração em produção sem backup ou teste em ambiente separado.** Rollback de Vercel não desfaz alterações no Supabase.
4. Não execute SQL 06 ou 07 para ativar investimentos; são funcionalidades independentes.
5. A aplicação e o SQL foram verificados estaticamente, não houve teste de login, RLS ou gravação em produção.

## Limitações

- Os saldos investidos são valores nominais de controle, sem atualização de preço, rendimentos, taxas ou impostos.
- A tela de relatórios ainda não apresenta uma demonstração específica dos investimentos; o resumo patrimonial aparece no início e na área Casal.
- O cálculo de saldo disponível é do aplicativo, não efetua transações bancárias reais.
- Se uma movimentação for registrada fora do aplicativo diretamente no banco, o cálculo pode não refletir operações externas.
