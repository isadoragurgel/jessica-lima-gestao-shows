# Jessica Lima — atualização visual e edição de lançamentos

Base: pacote anterior com a correção de gigs ADM (incluída nesta entrega).

Mudanças desta atualização:
- Edição de lançamento manual em página única, com descrição, data, valor, categoria e conta já preenchidos.
- Salvar alterações atualiza o mesmo registro de `mc_transactions`; não cria outro lançamento.
- A tela financeira ganhou cartões em cores suaves e fundo off-white.
- A tela inicial mantém a gig de hoje como destaque, com cartão mais definido e espaçamentos menores.
- No celular, a barra principal exibe Início, Agenda, Meu Controle, Contatos e Mais. Financeiro, Biblioteca e Perfil ficam acessíveis por Mais.

Preservado do pacote-base: correções ADM (concluir gig, prazo quinzenal, invoice bruta e receita líquida descontando músico).

Atenção: não foi possível testar operações contra seu Supabase real nem fazer testes interativos no celular. Faça um teste de edição com um lançamento manual pequeno antes de usar para dados importantes. Não altere lançamentos automáticos ou compartilhados por esta tela.

Não é necessário executar SQL novo para as alterações visuais e a edição de lançamentos.
