# Jessica Lima — correções de registros e financeiro simplificado
Atualize os arquivos na raiz do GitHub e faça Commit changes. A Vercel deve usar Framework Other, Build Command vazio, Output Directory `.`.

- Ações e formulários de gigs/tips usam o UUID permanente; registros de tips não podem ser vinculados silenciosamente a outra gig.
- Home sem gráfico de evolução mensal; Últimas gigs dá acesso ao histórico anterior a hoje.
- Financeiro separado em Invoices, Resumo, Tips e Músicos. O Resumo calcula cachês menos custo dos músicos mais tips. Registrar repasse não altera o custo nem o ganho líquido novamente.
- Recebimento da agência usa o valor bruto, sem descontar músico e sem incluir tips. As tips são separadas.
- Músicas a estudar aceita nomes livres, uma música por linha.

Para investigar 14/10 disndat e as tips, execute 02-diagnostico-gigs.sql (somente leitura) no SQL Editor e confira as duas datas. Este pacote não recria a gig nem move tips automaticamente: isso depende de verificar os registros reais.

Execute 01-pub-colors.sql apenas se ainda não executou. Não há nova migração obrigatória para esta atualização.
