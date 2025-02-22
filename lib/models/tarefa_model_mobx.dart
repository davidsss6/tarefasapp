import 'package:mobx/mobx.dart';

// Include generated file
part 'tarefa_model_mobx.g.dart';

// This is the class used by rest of your codebase
class TarefaModelMobXStore = _TarefaModelMobXStore with _$TarefaModelMobXStore;

abstract class _TarefaModelMobXStore with Store {
  @observable
  String? id;

  @observable
  String? descricao;

  @observable
  bool? concluido;

  _TarefaModelMobXStore({this.descricao, this.concluido, this.id});

  @action
  alterar(String pDescricao, bool pConcluido, String pId) {
    descricao = pDescricao;
    concluido = pConcluido;
    id = pId;
  }
}
