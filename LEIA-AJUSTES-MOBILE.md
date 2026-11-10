# Ajustes mobile — 10/11/2026

- Menu inferior: Início, Movimentos, +, Casal e Relatórios; Contas acessível em Casal no telemóvel. Desktop sem alteração.
- Filtros e cartões iniciais compactados no telemóvel.
- Ações dos fixos separadas em grelha, sem sobreposição.
- Recuperação de sessão: tenta recuperar a sessão Supabase existente ao regressar ao primeiro plano. Não prolonga tokens nem guarda palavras-passe.

Nenhum SQL necessário. Publicar primeiro em Preview Vercel. Se o login continuar a ser solicitado, é necessário diagnosticar armazenamento/cookies do iOS e eventos de autenticação; não há garantia de resolução em todos os iPhones.
