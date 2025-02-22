import 'package:flutter/material.dart';
import 'package:listatarefasapp/models/lista_tarefa_mobx_store.dart';

class ResultadoDialogMobx {
  ResultadoDialogMobx();

  String resultadoErroBuscaCep =
      "Voce precisa preencher o campo corretamente!\n\n Dicas:\n\n- Nao deixe o campo em branco.";

  void mostrarAlertDialog(
    ListaTarefaMobXStore listaTarefaMobXStore,
    BuildContext context,
    String objectId,
    String tarefa,
    bool concluida,
    bool editavel, {
    required VoidCallback onOkPressed,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController tarefaController =
            TextEditingController(text: tarefa);
        bool switchValue = concluida;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(editavel ? "Editar Tarefa" : "Nova Tarefa"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: tarefaController,
                    decoration: InputDecoration(labelText: 'Tarefa'),
                  ),
                  Row(
                    children: [
                      Text('Concluída'),
                      Switch(
                        value: switchValue,
                        onChanged: (bool value) {
                          setState(() {
                            switchValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    if (editavel) {
                      listaTarefaMobXStore.alterar(
                          objectId, tarefaController.text, switchValue);
                    } else {
                      listaTarefaMobXStore.adicionar(
                          tarefaController.text, concluida, objectId);
                    }
                    Navigator.of(context).pop();
                    onOkPressed();
                  },
                  child: Text(editavel ? 'Salvar' : 'OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void mostrarAlertDialogErro(BuildContext context, String mensagem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Erro"),
          content: Text(mensagem),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  String getMensagemErroBuscaCep() {
    return resultadoErroBuscaCep;
  }
}
