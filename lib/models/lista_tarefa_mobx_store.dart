import 'dart:ffi';

import 'package:listatarefasapp/models/dados_tarefa_back4app_model.dart';
import 'package:listatarefasapp/models/tarefa_model.dart';
import 'package:listatarefasapp/models/tarefa_model_mobx.dart';
import 'package:listatarefasapp/repository/crud_tarefa_repository_back4app.dart';
import 'package:mobx/mobx.dart';

// Include generated file
part 'lista_tarefa_mobx_store.g.dart';

// This is the class used by rest of your codebase
class ListaTarefaMobXStore = _ListaTarefaMobXStore with _$ListaTarefaMobXStore;

abstract class _ListaTarefaMobXStore with Store {

  ObservableList<TarefaModelMobXStore> _tarefas = ObservableList<TarefaModelMobXStore>();

  TarefaModel tarefaModel = TarefaModel();
  CrudTarefaBack4AppRepository crudContatoBack4AppRepository =
      CrudTarefaBack4AppRepository();
  var _dadosTarefaBack4appModel = ResultadosTarefasBack4AppModel([]);

  @computed // Olha alteraçoes dentro da lista
  List<TarefaModelMobXStore> get tarefas => apenasNaoConcluidos
    ? _tarefas.where((element) => element.concluido.toString() == "false").toList()
    : _tarefas.toList();

  @observable
  var _apenasNaoConcluidos = Observable(false);

  bool get apenasNaoConcluidos => _apenasNaoConcluidos.value;

  @action
  void carregarTarefas(List<TarefaModelMobXStore> novasTarefas) {
    _tarefas.clear(); // Limpa a lista antes de adicionar os novos itens
    _tarefas.addAll(novasTarefas); // Adiciona a nova lista de tarefas
  }

  @action
  void setNaoconcluidos(bool value) {
    _apenasNaoConcluidos.value = value;

  }

  void _adicionarNoBancoDeDados(String id, String descricao, bool concluido) async {
    await crudContatoBack4AppRepository.criarTarefa(
                          ResultadoTarefaBack4AppModel.criar(descricao, concluido));
  }


  @action
  void adicionar(String descricao, bool concluido, String id){
    _tarefas.add(TarefaModelMobXStore(descricao: descricao, concluido: concluido, id: id));
    _adicionarNoBancoDeDados(id, descricao, concluido);
  }


  void _alterarNoBancoDeDados(String id, String descricao, bool concluido) async {
    await crudContatoBack4AppRepository.atualizarTarefa(
                          ResultadoTarefaBack4AppModel.modificar(id, descricao, concluido));
  }

  @action
  void alterar(String id, String descricao, bool concluido){
    var tarefa = _tarefas.firstWhere((element) => element.id == id);
    tarefa.alterar(descricao, concluido, id);
    _alterarNoBancoDeDados(id, descricao, concluido);
  }


  void _excluirDoBancoDeDados(String id) async {
    await crudContatoBack4AppRepository.removerContato(id);
  }

  @action
  void excluir(String id){
    _tarefas.removeWhere((element) => element.id == id);
    _excluirDoBancoDeDados(id);

  }


}