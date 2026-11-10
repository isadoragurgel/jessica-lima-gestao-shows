# Atualização segura — 10/11/2026

Esta versão altera somente arquivos da interface (`nos.js`, `nos.html`, `index.html`, `nos.css`). NÃO execute SQL. NÃO apague nem recrie tabelas ou movimentos. Faça backup do projeto e do Supabase antes da publicação.

- Orçamento: seletor limpa após guardar.
- Previsão: utiliza o maior entre a soma dos salários dos perfis e as receitas fixas, evitando a dupla contagem óbvia. Se houver receitas extras, esta estimativa conservadora pode subestimar o total.
- Indicadores de previsto/realizado; espaçamentos; calculadora simples no valor (+ e -); seleção de emoji.
- Relatório de receitas por categoria; título de resumo com inicial maiúscula; orçamento na página inicial; percentuais de metas.
- Modelo híbrido proporcional: mostra a proporção calculada pelos rendimentos, sem atribuir automaticamente movimentos a pessoas ou fazer acertos. Para isso será necessário definir classificação de despesas compartilhadas e permissões.

Teste em aba anônima e com os dois logins antes de considerar concluído.
