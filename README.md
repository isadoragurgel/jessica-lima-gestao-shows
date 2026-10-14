# Jessica Lima | Gestão de Shows

Aplicativo web responsivo, com login e dados no Supabase. Abra pelo navegador no celular ou computador.

## Publicar pelo navegador

1. No GitHub, crie um repositório privado chamado `jessica-lima-gestao-shows`.
2. Use **Add file → Upload files** e envie os arquivos desta pasta, com `index.html` na raiz. Não envie o ZIP como único arquivo.
3. Na Vercel, escolha **Add New → Project**, conecte o GitHub e importe o repositório.
4. Em **Framework Preset**, escolha **Other**. Deixe **Build Command** vazio e informe `.` em **Output Directory**. Root Directory: raiz do repositório.
5. Clique **Deploy** e abra o endereço retornado pela Vercel.
6. Entre com a conta já criada no Supabase. Edite uma gig, espere **Salvo no Supabase**, recarregue e confira o valor.

## Dados e acesso

A URL do projeto Supabase e sua chave publishable estão no cliente, como previsto para esse tipo de chave. O acesso aos dados depende de autenticação e das políticas RLS configuradas no SQL já executado. Não use uma chave secret ou service_role no frontend.

Dados bancários e PPS não estão no código desta exportação; o perfil é carregado da tabela protegida no Supabase após o login. O SQL com os dados pessoais não faz parte deste pacote.

O aplicativo precisa de conexão para entrar e salvar. Esta versão não oferece modo offline.

## Estrutura

- `index.html`: interface e lógica do aplicativo.
- `vercel.json`: configuração de publicação.
- `.gitignore`: exclusão de arquivos locais e credenciais.
