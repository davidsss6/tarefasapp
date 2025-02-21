import 'package:flutter/material.dart';
import 'package:listatarefasapp/models/dados_tarefa_back4app_model.dart';
import 'package:listatarefasapp/repository/crud_tarefa_repository_back4app.dart';

class ResultadoDialog {
  ResultadoDialog();

  static String resultadoErroBuscaCep =
      "Voce precisa preencher o campo corretamente!\n\n Dicas:\n\n- Nao deixe o campo em branco.";

  static void mostrarAlertDialog(
    BuildContext context,
    String objectId,
    String tarefa,
    bool concluida,
    bool editavel, {
    required VoidCallback onOkPressed,
  }) async {
    String title;
    if (editavel) {
      title = "Editar Dados da Tarefa";
    } else {
      title = "Dados da tarefa";
    }

    TextEditingController tarefaController =
        TextEditingController(text: tarefa);
    
    CrudTarefaBack4AppRepository crudTarefaBack4AppRepository =
        CrudTarefaBack4AppRepository();

    showDialog(
      context: context,
      builder: (context) {
        bool switchValue = concluida; // Local state for the switch

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: tarefaController,
                      decoration: InputDecoration(labelText: 'Tarefa'),
                    ),
                    Row(
                      children: [
                        Text('Concluida'),
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
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () async {
                    if (editavel) {
                      await crudTarefaBack4AppRepository.atualizarTarefa(
                          ResultadoTarefaBack4AppModel.modificar(
                              objectId, tarefaController.text.toString(), switchValue));
                    } else {
                      await crudTarefaBack4AppRepository.criarTarefa(
                          ResultadoTarefaBack4AppModel.criar(
                              tarefaController.text.toString(), switchValue));
                    }
                    Navigator.of(context).pop();
                    onOkPressed();
                  },
                  child: editavel ? Text('Salvar') : Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  static void mostrarAlertDialogErro(BuildContext context, String mensagem) {
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

  static String getMensagemErroBuscaCep() {
    return resultadoErroBuscaCep;
  }
}
