# Correções seguras
- Perfil: retorno da atualização usa `user_id`, pois `mc_member_profiles` não possui `id`. Confirmado no esquema do Supabase por consulta de leitura.
- Rendimentos e investimento inicial: formato pt-PT, com conversão antes de gravar.
- Movimentos: filtro de categoria adicionado.
- Criação pública de espaços e moeda configurável ainda não implementadas: requerem revisão de onboarding, RLS e cálculos.
- Não foram executadas migrações nem alterações de dados no Supabase.
- Testar ambos os logins em Preview antes de publicar.
