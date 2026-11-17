# Movimento dividido entre duas contas

No cadastro ou edição de uma receita ou despesa, marque **Dividir este movimento entre duas contas**, indique o valor da primeira e selecione a segunda. O restante é calculado automaticamente. A soma é validada pelo banco em uma única gravação atômica.

O movimento continua único em relatórios, categorias e totais. Os saldos por conta usam as parcelas. Na edição, desmarcar a divisão volta a usar uma conta. Excluir o movimento elimina ambas as parcelas porque são armazenadas na própria transação.

O banco foi atualizado com `nos_transactions.account_splits` e uma validação de segurança. Não é necessário executar SQL do ZIP.

**Limitação:** a divisão é entre exatamente duas contas e não está disponível para transferências. O app ainda não possui testes automatizados completos em iPhone; testar com dois valores e conferir saldos, edição, exclusão e relatórios antes do uso real.
