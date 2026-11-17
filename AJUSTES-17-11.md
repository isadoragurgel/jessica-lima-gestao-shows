# Ajustes de 17/11

- Corrigida a largura do campo de data no iOS e o overflow horizontal do formulário.
- Barra inferior ancorada à viewport em telas móveis, respeitando a área segura do iPhone.
- Sincronização entre dispositivos: Supabase Realtime para movimentos, contas, fixos e investimentos, com verificação adicional a cada 15 segundos e ao voltar ao aplicativo. O Realtime depende de as tabelas estarem incluídas na publicação do Supabase.
- **Pagamento por duas contas ainda não foi implementado.** Requer vínculo persistente entre as parcelas, gravação atômica e adaptação dos relatórios, edição e exclusão para evitar contagem dupla.

Teste no iPhone: abrir/fechar modal, tocar em data e outros campos, rolar página, trocar de aba, salvar movimento no aparelho A e verificar no B.
