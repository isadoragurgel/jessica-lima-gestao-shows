# Ajustes de interface

- Movimento: descrição, valor e categoria antes da data. Categoria inclui opção de dividir em duas categorias, com valor restante automático.
- Relatórios, filtros, gráfico e orçamento consideram os valores por categoria, sem duplicar o total.
- Metas: números em formato local, botões sem quebra, exclusão definitiva mediante confirmação. A exclusão respeita a política do Supabase: apenas o criador pode excluir.
- Campos de mês e modelo financeiro padronizados.
- Linhas de movimentos adaptadas ao celular.

Requer a coluna `nos_transactions.category_splits` e o trigger de validação, já adicionados no Supabase.

Teste antes de usar com valores importantes.
