

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:listatarefasapp/models/dados_tarefa_back4app_model.dart';
import 'package:listatarefasapp/models/tarefa_model.dart';
import 'package:listatarefasapp/repository/crud_tarefa_repository_back4app.dart';
import 'package:listatarefasapp/service/dark_mode_service.dart';
import 'package:listatarefasapp/shared_widgets/resultado_dialog.dart';
import 'package:listatarefasapp/shared_widgets/text_label_titulo.dart';
import 'package:provider/provider.dart';

class ListaTarefasPAgeState extends StatefulWidget {
  const ListaTarefasPAgeState({Key? key}) : super(key: key);

  @override
  State<ListaTarefasPAgeState> createState() => ListaTarefasPageState();
}

class ListaTarefasPageState extends State<ListaTarefasPAgeState> {
  var TarefaDigitadaController = TextEditingController();
  TarefaModel tarefaModel = TarefaModel();
  CrudTarefaBack4AppRepository crudContatoBack4AppRepository =
      CrudTarefaBack4AppRepository();
  var _dadosTarefaBack4appModel = ResultadosTarefasBack4AppModel([]);
  var carregando = false;
  bool apenasTarefasNaoConcluidas = false;
  static const IMG_URL_EXTERNO =
      "https://backend.back4app.com/bundles/img/46ee181cb89250b5d39e.png";

  @override
  void initState() {
    super.initState();
    obterTarefasCadastradas();
  }

  void obterTarefasCadastradas() async {
    setState(() {
      carregando = true;
    });

    try {
      if(apenasTarefasNaoConcluidas){
        _dadosTarefaBack4appModel =
          await crudContatoBack4AppRepository.obterTarefaNaoConcluidas();
      }else{
        _dadosTarefaBack4appModel =
          await crudContatoBack4AppRepository.obterTarefa();
      }
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 60, 65, 212),
        title: const Text('Lista de Tarefas'),
        actions: [
          const Center(
            child: Text(
              'Dark Mode',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Consumer<DarkModeService>(
            builder: (_, darkmModeService, Widget) {
              return Switch(
                  value: darkmModeService.isDarkMode,
                  onChanged: (bool value) {
                    darkmModeService.changeTheme();
                  });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(
                "lib/images/logo_app.png",
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 20),
              const TextLabelTitulo(texto: "Minhas Tarefas"),
              Row(
                children: [
                  Text('Apenas não concluidas: '),
                  Switch(
                    value: apenasTarefasNaoConcluidas,
                    onChanged: (bool value) {
                      setState(() {
                        apenasTarefasNaoConcluidas = !apenasTarefasNaoConcluidas;
                        obterTarefasCadastradas();
                      });
                    },
                  ),
                ],
              ),
              carregando
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _dadosTarefaBack4appModel.resultados.length,
                      itemBuilder: (BuildContext context, int index) {
                        var tarefaBack4App =
                            _dadosTarefaBack4appModel.resultados[index];
                        return Stack(
                          children: [
                            ListTile(
                              onTap: () {
                                try {
                                  ResultadoDialog.mostrarAlertDialog(
                                      context,
                                      tarefaBack4App.objectId.toString(),
                                      tarefaBack4App.descricao.toString(),
                                      true,
                                      true, onOkPressed: () {
                                    setState(() {
                                      obterTarefasCadastradas();
                                    });
                                  });
                                } catch (e) {
                                  print(e.toString());
                                }
                              },
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                        "Tarefa: ${tarefaBack4App.descricao}"),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        size: 20, color: Colors.red),
                                    onPressed: () async {
                                      await crudContatoBack4AppRepository
                                          .removerContato(
                                              _dadosTarefaBack4appModel
                                                  .resultados[index].objectId
                                                  .toString());
                                      setState(() {
                                        obterTarefasCadastradas();
                                      });
                                    },
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                  "Concluido: ${tarefaBack4App.concluido.toString()} "),
                            ),
                          ],
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.extended(
              onPressed: () {
                try {
                  ResultadoDialog.mostrarAlertDialog(
                      this.context, "", "", false, false, onOkPressed: () {
                    setState(() {
                      obterTarefasCadastradas();
                    });
                  });
                  print('Adicionar item à lista de tarefas');
                } catch (e) {
                  print('Erro: ' + e.toString());
                }
              },
              heroTag: "btnAdd",
              tooltip: 'Adicionar tarefa',
              icon: const Icon(Icons.add), // Ícone do botão
              label: const Text('Adicionar'), // Texto do botão
            ),
            const SizedBox(width: 16),
            FloatingActionButton.extended(
              onPressed: () {
                SystemNavigator.pop();
              },
              heroTag: "btnExit",
              tooltip: 'Sair do App',
              icon: const Icon(Icons.exit_to_app), // Ícone do botão
              label: const Text('Sair'), // Texto do botão
            ),
          ],
        ),
      ),
    );
  }
}
