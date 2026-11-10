# nós. — Gráficos e observações

Atualização sobre a versão com login corrigido.

- Relatórios: gráfico de rosca por categoria, barras com os últimos seis meses e orçamento por categoria.
- Movimentos: campo opcional **Observações / notas** em receitas, despesas e transferências; aparece na lista e nos relatórios, inclusive Excel/PDF.
- Dados: utiliza a coluna `notes` já presente em `nos_transactions` na migração da Fase 4. **Não requer SQL novo**, se a migração completa já foi executada.
- Os gráficos refletem somente os lançamentos novos da família e o mês escolhido.
- A navegação inferior e o login são preservados.

## Publicação

Substitua os arquivos na raiz do repositório GitHub e aguarde a Vercel. Teste login com as duas contas, salve uma despesa com observação e confira o relatório.

Observação: esta versão não foi testada contra o Supabase de produção.
