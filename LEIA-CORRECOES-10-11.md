# Correções de 10/11/2026

- Corrigida a diferença entre index.html e nos.html: ambos agora têm os elementos de receitas/gastos fixos que nos.js utiliza. Isso eliminava o erro de `innerHTML` nulo ao abrir a página principal.
- Modo conjunto oculta as regras de divisão.
- Removido o campo técnico JSON; percentuais personalizados e valor fixo usam campos legíveis.
- Moeda exibida como € 1.234,56.

## Publicação
Substitua os arquivos na raiz do GitHub e aguarde o deploy Vercel. Não precisa executar SQL adicional. Abra o site em aba anônima para confirmar o novo código.

## Limitações
Sem acesso ao Supabase de produção, não foi possível testar os dados reais nem as políticas de acesso.
