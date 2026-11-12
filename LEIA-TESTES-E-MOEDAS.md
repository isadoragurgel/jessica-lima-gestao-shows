# Correções e próximos passos

- Corrigido `sharing is not defined` no fluxo de despesa compartilhada: o valor é agora lido diretamente do formulário.
- Atenção: na versão anterior, o movimento podia ter sido gravado antes do erro de divisão. Verifique se o lançamento de teste já existe antes de repetir.
- Ajustes CSS: botões de exportação lado a lado, filtros compactos, botão de registo e valores de metas sem quebra dentro dos números.
- Campo calculado: instrução e teclado de expressão só em dispositivos com ponteiro preciso; em toque, teclado decimal e introdução simples.
- Saldo inicial investido do casal: formato numérico português na edição.
- Moedas dos investimentos: NÃO implementado no banco. Proposta: manter cada posição com moeda ISO própria, mostrar subtotais por moeda, e nunca somar valores de moedas diferentes sem conversão explícita e taxa datada. Necessita desenho e migração com backup.
- Não foram modificados dados ou políticas do Supabase.
- Preview Vercel pode continuar a usar a base de produção. Não testar lançamentos sem Supabase separado.
- Testar antes de publicar; apenas validação de sintaxe foi executada.
