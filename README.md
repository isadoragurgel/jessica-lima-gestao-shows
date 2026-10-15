# Jessica Lima — custo do músico na conclusão
Envie todos os arquivos extraídos para a raiz do repositório, substitua os anteriores e faça Commit changes. Vercel: Framework Other, Build Command vazio, Output Directory `.`.

Ao concluir uma gig, o cachê do músico já cadastrado é reconhecido como custo e abatido do ganho líquido, sem depender da invoice ter sido paga. Isso não lança dinheiro como recebido e não cria um pagamento bancário fictício. A Visão Geral mostra um único Cachê dos músicos. Exceções de valor continuam editáveis dentro de cada gig, e pagamentos efetivamente registrados permanecem no histórico.

Os registros reais de pagamentos existentes são preservados. Esta versão deixa de gerar pagamentos automáticos ao receber uma invoice. A coluna musician_payment_mode, se criada anteriormente, pode continuar no banco sem uso; não é necessário removê-la.

Mantém cores por pub, calendário .ics, login, Supabase e histórico de invoices. Execute 01-pub-colors.sql uma vez se ainda não executou. Não há novo SQL para o custo do músico.

Supabase URL Configuration:
Site URL: https://jessica-lima-gestao-shows.vercel.app
Redirect URL: https://jessica-lima-gestao-shows.vercel.app/reset-password.html
