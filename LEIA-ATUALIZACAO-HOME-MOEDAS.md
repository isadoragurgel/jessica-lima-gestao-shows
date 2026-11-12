# Ajustes de visualização — nós.

- Home: movimentos recentes agrupados por data.
- Formulários de saldo inicial investido (individual e casal): seletor de moeda antes do valor.
- Valores de investimentos: símbolo monetário antes do número, com agrupamento de milhares por ponto.
- Home: investimentos iniciais incluídos em BRL, USD e GBP aparecem em linhas separadas no painel Investimentos.
- O patrimônio consolidado em EUR continua somando somente investimentos em EUR. Não há conversão cambial.
- Aportes/resgates existentes continuam em EUR; não foi implementada movimentação multimoeda.
- A moeda principal das contas continua EUR.
- Nenhum SQL é executado pelo pacote. Não altera registros existentes.

Teste em ambiente seguro antes de publicar. Preview da Vercel usa a mesma base se não houver Supabase separado.
