# Atualização: híbrido proporcional e acertos

1. FAÇA BACKUP do Supabase e guarde a versão anterior do site.
2. Execute `06-nos-hibrido-acertos.sql` no SQL Editor. Ele cria duas tabelas NOVAS e um trigger; não apaga ou reclassifica transações existentes.
3. Publique o ZIP no GitHub e teste primeiro com um lançamento pequeno.
4. Em Casal, configure o modelo Híbrido e regra Proporcional aos rendimentos. Preencha os rendimentos dos dois perfis.
5. Ao criar uma despesa, marque Compartilhada e escolha quem pagou. Só essas despesas entram no painel de acertos.
6. O botão Registrar acerto registra um acerto lógico, mas NÃO executa transferência bancária.

LIMITAÇÕES IMPORTANTES: rendimentos são lidos dos perfis atuais, sem histórico mensal; alterar rendimentos poderá recalcular meses anteriores. A implementação considera pagamentos por pessoas e não faz repartição de contas conjuntas. Não use o módulo para acertar valores reais de meses passados sem conferência manual. O cadastro de despesa e sua classificação compartilhada são duas operações distintas: em caso de falha da segunda, a despesa pode ter sido salva, mas não classificada. Confira os movimentos antes de repetir.
