# Próxima etapa — modo Individual do nós.

Status: **planejado, ainda não ativado**.

Fluxo acordado: cadastro por e-mail e senha; escolha Individual ou Casal; criação de espaço financeiro e moeda; configuração de contas e rendimentos; convite opcional no Casal.

Individual terá um espaço financeiro privado com um membro. A pessoa poderá posteriormente criar um **novo** espaço Casal, sem migrar automaticamente histórico, saldos ou investimentos. A possibilidade de alternar entre espaços será uma segunda etapa.

Antes de ativar cadastro público, implementar e testar no Supabase uma função segura de criação de espaços, políticas RLS, escolha do tipo de espaço e tratamento de usuários sem vínculo. O código atual ainda pressupõe que o usuário já pertence a um espaço Casal; não basta expor um botão de cadastro.

Preservar os espaços existentes, movimentos, contas, investimentos e políticas de segurança. Não criar espaço novo para usuários já cadastrados.
