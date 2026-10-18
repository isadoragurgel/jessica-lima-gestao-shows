# Jessica Lima — interface aprovada
Execute o SQL Cash in hand fornecido separadamente. Depois envie os arquivos deste ZIP à raiz do GitHub e faça Commit changes. Framework Other; Build Command vazio; Output Directory `.`.

Concluir gig é uma ação principal. Ao concluir, aparece Realizada em verde claro. Cancelar gig fica em Ver detalhes, com confirmação, preserva o histórico e exclui a gig dos totais/previsões. Gigs com dados financeiros precisam ter esses registros revisados antes do cancelamento.

Repasses têm linhas compactas: Marcar pago confirma o saldo na data de hoje, sem alterar novamente o custo/líquido. Detalhes permite exceções.

Biblioteca → Estudo tem apenas um campo para músicas, uma por linha. Salvar mantém IDs de músicas inalteradas e o repertório já pronto.

Confirmações abrem em dialog visível no centro da tela. Excluir rascunho preserva shows e recebimentos; invoices emitidas continuam protegidas.

Cash in hand é uma condição de pagamento, sem marcar automaticamente como recebido. O gráfico considera o mês inteiro, separando realizado/previsão e valores pendentes. Nenhuma alteração de interface movimenta pagamentos ou apaga gigs no banco automaticamente.

Ao preencher o inicio de uma gig, o termino e sugerido duas horas depois, incluindo a virada de dia. O horario final pode ser editado manualmente. A legenda de tags de pubs abaixo do calendario foi removida.

Ajuste visual: Concluir gig e Ver detalhes com dimensões equivalentes e fundo discreto. Repasses exibem data, pub e músico, nessa ordem. Não exige novo SQL.
Ambiente de teste: teste-melhorias
