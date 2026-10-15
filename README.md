# Jessica Lima — login e Supabase
Envie TODOS os arquivos extraídos para a raiz do repositório e faça Commit changes. Aguarde a Vercel concluir a publicação. Framework Other, Build Command vazio, Output Directory `.`.

Inclui a biblioteca Supabase no próprio site, sem importação de esm.sh para login/recuperação, e limites de espera de rede.

Supabase → Authentication → URL Configuration:
Site URL: https://jessica-lima-gestao-shows.vercel.app
Redirect URLs: https://jessica-lima-gestao-shows.vercel.app/reset-password.html

Depois abra /reset-password.html e solicite um NOVO email de recuperação. Use o email mais recente, defina a senha e entre no app.

Esta versão exige login e salva no Supabase. Os registros de exemplo são substituídos pelos dados autorizados do banco após o login. Não recrie/exclua a usuária. Dados bancários e PPS não estão neste pacote.

O modo instalado na tela inicial exige internet para autenticar e salvar. O cache da demonstração anterior é removido automaticamente. Verifique o retorno “Salvo no Supabase” e recarregue para testar uma mudança antes de registrar todo o histórico.

Invoices no topo do Financeiro, histórico de emissão e pagamentos, download e email pré-preenchido. Anexe manualmente o PDF baixado; nenhum email é enviado automaticamente. Mantém dados nas tabelas já criadas, sem novo SQL.
