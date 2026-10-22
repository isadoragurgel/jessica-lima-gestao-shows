# Jessica Lima — Preview integrado

Esta é uma versão de teste, não uma publicação de produção.

Inclui ajustes reais: notas visíveis também nos cartões das gigs, próximas gigs sem limitar à semana, mês corrente no contador da tela inicial, datas com ano no calendário, canceladas fora do dia selecionado e diferenciação de cores Solo/Duo. Preserva as funcionalidades anteriores do ZIP de base, incluindo meta semanal editável e rascunhos mensais existentes.

Não inclui importação automática de maio a setembro: dados extraídos de imagens precisam de validação e de um processo idempotente de importação antes de gravar no Supabase. A interface não foi integralmente redesenhada e não houve testes end-to-end com Supabase.

Não faça merge na main sem testar. Um Preview pode apontar para o banco de produção.
