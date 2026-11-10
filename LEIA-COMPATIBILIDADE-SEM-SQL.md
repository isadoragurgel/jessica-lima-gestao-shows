# nós. — Correção de compatibilidade sem SQL

Esta versão evita que a ausência de `public.nos_shared_expenses` e `public.nos_settlement_payments` impeça a leitura dos dados existentes. O painel de acertos fica indisponível até as tabelas existirem.

**Não execute SQL para instalar esta versão.** Nenhum script SQL é executado automaticamente pelo site.

As despesas pessoais continuam sendo registradas na tabela original `nos_transactions`. Não há classificação retroativa nem alteração de dados antigos.

Para instalar: publique os arquivos do ZIP no mesmo repositório e mantenha a mesma configuração Supabase. Teste a página, metas, contas, movimentos e orçamento com os dois logins. Se houver problemas, faça rollback da Vercel; rollback não reverte alterações de banco.

O pacote mantém arquivos SQL históricos apenas como referência. Não os execute.

Verificações locais: sintaxe JavaScript e integridade do ZIP. Não foi realizado teste autenticado do frontend em produção.
