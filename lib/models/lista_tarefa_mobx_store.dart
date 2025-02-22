import 'package:listatarefasapp/models/dados_tarefa_back4app_model.dart';
import 'package:listatarefasapp/models/tarefa_model.dart';
import 'package:listatarefasapp/models/tarefa_model_mobx.dart';
import 'package:listatarefasapp/repository/crud_tarefa_repository_back4app.dart';
import 'package:mobx/mobx.dart';

// Include generated file
part 'lista_tarefa_mobx_store.g.dart';

class ListaTarefaMobXStore = _ListaTarefaMobXStore with _$ListaTarefaMobXStore;

abstract class _ListaTarefaMobXStore with Store {
  final ObservableList<TarefaModelMobXStore> _tarefas =
      ObservableList<TarefaModelMobXStore>();

  TarefaModel tarefaModel = TarefaModel();
  CrudTarefaBack4AppRepository crudContatoBack4AppRepository =
      CrudTarefaBack4AppRepository();

  @computed // Olha alteraçoes dentro da lista
  List<TarefaModelMobXStore> get tarefas => apenasNaoConcluidos
      ? _tarefas
          .where((element) => element.concluido.toString() == "false")
          .toList()
      : _tarefas.toList();

  @observable
  var _apenasNaoConcluidos = Observable(false);

  bool get apenasNaoConcluidos => _apenasNaoConcluidos.value;

  @action
  Future<void> carregarTarefasDoBanco() async {
    try {
      var dadosTarefaBack4appModel =
          await crudContatoBack4AppRepository.obterTarefa();

      var tarefasConvertidas =
          dadosTarefaBack4appModel.resultados.map((tarefa) {
        return TarefaModelMobXStore(
          descricao: tarefa.descricao ?? "",
          concluido: tarefa.concluido ?? false,
          id: tarefa.objectId ?? "",
        );
      }).toList();

      carregarTarefas(tarefasConvertidas);
    } catch (e) {
      print("Erro ao carregar tarefas: ${e.toString()}");
    }
  }

  @action
  void carregarTarefas(List<TarefaModelMobXStore> novasTarefas) {
    _tarefas.clear();
    _tarefas.addAll(novasTarefas);
  }

  @action
  void setNaoconcluidos(bool value) {
    _apenasNaoConcluidos.value = value;
  }

  void _adicionarNoBancoDeDados(
      String id, String descricao, bool concluido) async {
    await crudContatoBack4AppRepository
        .criarTarefa(ResultadoTarefaBack4AppModel.criar(descricao, concluido));
  }

  @action
  void adicionar(String descricao, bool concluido, String id) {
    _tarefas.add(TarefaModelMobXStore(
        descricao: descricao, concluido: concluido, id: id));
    _adicionarNoBancoDeDados(id, descricao, concluido);
  }

  void _alterarNoBancoDeDados(
      String id, String descricao, bool concluido) async {
    await crudContatoBack4AppRepository.atualizarTarefa(
        ResultadoTarefaBack4AppModel.modificar(id, descricao, concluido));
  }

  @action
  void alterar(String id, String descricao, bool concluido) {
    var tarefa = _tarefas.firstWhere((element) => element.id == id);
    tarefa.alterar(descricao, concluido, id);
    _alterarNoBancoDeDados(id, descricao, concluido);
  }

  void _excluirDoBancoDeDados(String id) async {
    await crudContatoBack4AppRepository.removerContato(id);
  }

  @action
  void excluir(String id) {
    _tarefas.removeWhere((element) => element.id == id);
    _excluirDoBancoDeDados(id);
  }
}
