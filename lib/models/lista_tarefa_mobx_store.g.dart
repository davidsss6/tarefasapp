// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lista_tarefa_mobx_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ListaTarefaMobXStore on _ListaTarefaMobXStore, Store {
  Computed<List<TarefaModelMobXStore>>? _$tarefasComputed;

  @override
  List<TarefaModelMobXStore> get tarefas => (_$tarefasComputed ??=
          Computed<List<TarefaModelMobXStore>>(() => super.tarefas,
              name: '_ListaTarefaMobXStore.tarefas'))
      .value;

  late final _$_apenasNaoConcluidosAtom = Atom(
      name: '_ListaTarefaMobXStore._apenasNaoConcluidos', context: context);

  @override
  Observable<bool> get _apenasNaoConcluidos {
    _$_apenasNaoConcluidosAtom.reportRead();
    return super._apenasNaoConcluidos;
  }

  @override
  set _apenasNaoConcluidos(Observable<bool> value) {
    _$_apenasNaoConcluidosAtom.reportWrite(value, super._apenasNaoConcluidos,
        () {
      super._apenasNaoConcluidos = value;
    });
  }

  late final _$_ListaTarefaMobXStoreActionController =
      ActionController(name: '_ListaTarefaMobXStore', context: context);

  @override
  void carregarTarefas(List<TarefaModelMobXStore> novasTarefas) {
    final _$actionInfo = _$_ListaTarefaMobXStoreActionController.startAction(
        name: '_ListaTarefaMobXStore.carregarTarefas');
    try {
      return super.carregarTarefas(novasTarefas);
    } finally {
      _$_ListaTarefaMobXStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNaoconcluidos(bool value) {
    final _$actionInfo = _$_ListaTarefaMobXStoreActionController.startAction(
        name: '_ListaTarefaMobXStore.setNaoconcluidos');
    try {
      return super.setNaoconcluidos(value);
    } finally {
      _$_ListaTarefaMobXStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void adicionar(String descricao, bool concluido, String id) {
    final _$actionInfo = _$_ListaTarefaMobXStoreActionController.startAction(
        name: '_ListaTarefaMobXStore.adicionar');
    try {
      return super.adicionar(descricao, concluido, id);
    } finally {
      _$_ListaTarefaMobXStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void alterar(String id, String descricao, bool concluido) {
    final _$actionInfo = _$_ListaTarefaMobXStoreActionController.startAction(
        name: '_ListaTarefaMobXStore.alterar');
    try {
      return super.alterar(id, descricao, concluido);
    } finally {
      _$_ListaTarefaMobXStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void excluir(String id) {
    final _$actionInfo = _$_ListaTarefaMobXStoreActionController.startAction(
        name: '_ListaTarefaMobXStore.excluir');
    try {
      return super.excluir(id);
    } finally {
      _$_ListaTarefaMobXStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tarefas: ${tarefas}
    ''';
  }
}
