# Fase 1 — preparação não destrutiva

- O projeto existente permanece sem mudanças de comportamento.
- `casal-preview.html` é a nova proposta visual navegável, com dados fictícios, acessível em `/casal-preview.html` após implantação.
- O protótipo ainda não utiliza Supabase nem modifica os lançamentos existentes.
- A Agenda e a lógica de gigs continuam no aplicativo atual até a migração ser validada.

## Próximas tarefas
1. Auditar esquema e políticas RLS do Supabase.
2. Criar espaços de casal, membros e convite de segundo login.
3. Migrar dados sem excluir registros nem duplicar receitas.
4. Conectar os cinco ecrãs financeiros aos dados reais.
5. Ocultar gigs somente após validar a nova navegação e saldos.

Nenhum SQL é necessário para abrir a prévia.
