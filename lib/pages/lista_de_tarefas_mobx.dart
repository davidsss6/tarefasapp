import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:listatarefasapp/models/dados_tarefa_back4app_model.dart';
import 'package:listatarefasapp/models/lista_tarefa_mobx_store.dart';
import 'package:listatarefasapp/models/tarefa_model_mobx.dart';
import 'package:listatarefasapp/repository/crud_tarefa_repository_back4app.dart';
import 'package:listatarefasapp/service/dark_mode_service.dart';
import 'package:listatarefasapp/shared_widgets/resultado_dialog_mobx.dart';
import 'package:listatarefasapp/shared_widgets/text_label_titulo.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ListaTarefasMobxPageState extends StatefulWidget {
  const ListaTarefasMobxPageState({Key? key}) : super(key: key);

  @override
  State<ListaTarefasMobxPageState> createState() => ListaTarefasMobx();
}

class ListaTarefasMobx extends State<ListaTarefasMobxPageState> {


  var _listaTarefaMobXStore = ListaTarefaMobXStore();
  get tarefaModelMobXStore => _listaTarefaMobXStore;


  var resultadoDialogMobx = ResultadoDialogMobx(); 
  var carregando = false;
  bool apenasTarefasNaoConcluidas = false;

  var _dadosTarefaBack4appModel = ResultadosTarefasBack4AppModel([]);
  CrudTarefaBack4AppRepository crudContatoBack4AppRepository =
      CrudTarefaBack4AppRepository();

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
    _dadosTarefaBack4appModel = await crudContatoBack4AppRepository.obterTarefa();

    // Converte os dados do banco para o modelo MobX
    var tarefasConvertidas = _dadosTarefaBack4appModel.resultados.map((tarefa) {
      return TarefaModelMobXStore(
        descricao: tarefa.descricao ?? "",
        concluido: tarefa.concluido ?? false,
        id: tarefa.objectId ?? "",
      );
    }).toList();

    // Adiciona as tarefas convertidas à store MobX
    _listaTarefaMobXStore.carregarTarefas(tarefasConvertidas);

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
              child: Observer(builder: (context) {
                  return Column(
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
                          Observer(
                            builder: (_) {
                              return Switch(
                                value: _listaTarefaMobXStore.apenasNaoConcluidos,
                                onChanged: _listaTarefaMobXStore.setNaoconcluidos);
                            }
                          ),
                        ],
                      ),
                      carregando
                          ? const CircularProgressIndicator()
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _listaTarefaMobXStore.tarefas.length,
                              itemBuilder: (BuildContext context, int index) {
                                var tarefaMobx = _listaTarefaMobXStore.tarefas[index];
                                return Stack(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        try {
                                          print("Tarefa Id"+tarefaMobx.id.toString()+"Texto Tarefa:"+tarefaMobx.descricao.toString()+"Tarefa Concluida:"+tarefaMobx.concluido.toString());
                                          resultadoDialogMobx.mostrarAlertDialog(
                                             _listaTarefaMobXStore,
                                              context,
                                              tarefaMobx.id.toString(),
                                              tarefaMobx.descricao.toString(),
                                              tarefaMobx.concluido.toString() == "true" ? true : false,
                                              true, onOkPressed: () {
        
                                            setState(() {
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
                                                "Tarefa: ${tarefaMobx.descricao}"),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete,
                                                size: 20, color: Colors.red),
                                            onPressed: () {
                                              _listaTarefaMobXStore.excluir(tarefaMobx.id.toString());
                                            },
                                          ),
                                        ],
                                      ),
                                      subtitle: Text(
                                          "Concluido: ${tarefaMobx.concluido.toString()} "),
                                    ),
                                  ],
                                );
                              },
                            ),
                    ],
                  );
                }
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
                      resultadoDialogMobx.mostrarAlertDialog(
                        _listaTarefaMobXStore,
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
