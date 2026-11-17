# Fase 1 — Estrutura de espaços

Supabase: `mc_households` recebeu `space_type` (`couple` por padrão) e `currency` (`EUR` por padrão). Nenhum espaço existente foi convertido.

Frontend: adapta rótulos e esconde controles de divisão do casal quando `space_type=individual`. O login existente continua igual.

**Ainda não habilita o cadastro Individual.** Próximos passos: criação segura de espaço para novos usuários, fluxo de confirmação de email, configuração inicial e teste com conta nova. Não altere manualmente o tipo de um espaço de produção para testar.
