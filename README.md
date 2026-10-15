# Jessica Lima | Gestão de Shows — atualização

Envie TODOS os arquivos extraídos para a raiz do repositório, substitua os anteriores e faça Commit changes. Vercel: Framework Other, Build Command vazio, Output Directory `.`.

- Calendário manual removido.
- Tag Realizada em verde claro.
- Contador mensal de gigs realizadas, confirmadas e em negociação; canceladas excluídas.
- Removido código da antiga prévia que bloqueava links de download e de email.
- PDF: Baixar PDF ou Compartilhar PDF no iPhone, quando suportado.
- Email: abre o aplicativo configurado com destinatário/assunto/texto em inglês; copie a mensagem se não houver cliente configurado. Anexe o PDF baixado manualmente. Não há envio automático nem confirmação de entrega.
- Cachê do músico reconhecido como custo na conclusão. Recebimentos e pagamentos efetivos continuam separados.
- Mantém login, Supabase, cores por pub e histórico de invoices.

Execute 01-pub-colors.sql somente se ainda não executou. Não há novo SQL nesta atualização.

Supabase URL Configuration:
Site URL: https://jessica-lima-gestao-shows.vercel.app
Redirect URL: https://jessica-lima-gestao-shows.vercel.app/reset-password.html

Depois de publicar, abra o endereço principal da Vercel e recarregue. Testes locais verificaram contador, PDF gerado, acionamento do download e preparação de email; o fluxo real de download/compartilhamento precisa ser conferido no aparelho.

A gestão separada de Extras foi retirada da interface. Use Nova gig para apresentações avulsas e recorrência semanal para gigs fixas. Registros antigos no banco não são apagados por esta atualização.

Excluir rascunho: disponível no card e na revisão, com confirmação. Apenas rascunhos são excluídos; gigs/tips/recebimentos preservados. No Supabase a exclusão filtra status Rascunho e os itens são removidos pelo cascade já existente. Não exige SQL novo.

Duos do mês: Registrar pagamento confirma o repasse do saldo ao músico na data de hoje e mostra Pago. Não altera o cachê nem desconta novamente do líquido. Ajustar repasse permite exceções e correções de data/valor. Não exige novo SQL.
