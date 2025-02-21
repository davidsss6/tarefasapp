// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tarefa_model_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TarefaModelMobXStore on _TarefaModelMobXStore, Store {
  late final _$idAtom =
      Atom(name: '_TarefaModelMobXStore.id', context: context);

  @override
  String? get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(String? value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  late final _$descricaoAtom =
      Atom(name: '_TarefaModelMobXStore.descricao', context: context);

  @override
  String? get descricao {
    _$descricaoAtom.reportRead();
    return super.descricao;
  }

  @override
  set descricao(String? value) {
    _$descricaoAtom.reportWrite(value, super.descricao, () {
      super.descricao = value;
    });
  }

  late final _$concluidoAtom =
      Atom(name: '_TarefaModelMobXStore.concluido', context: context);

  @override
  bool? get concluido {
    _$concluidoAtom.reportRead();
    return super.concluido;
  }

  @override
  set concluido(bool? value) {
    _$concluidoAtom.reportWrite(value, super.concluido, () {
      super.concluido = value;
    });
  }

  late final _$_TarefaModelMobXStoreActionController =
      ActionController(name: '_TarefaModelMobXStore', context: context);

  @override
  dynamic alterar(String pDescricao, bool pConcluido, String pId) {
    final _$actionInfo = _$_TarefaModelMobXStoreActionController.startAction(
        name: '_TarefaModelMobXStore.alterar');
    try {
      return super.alterar(pDescricao, pConcluido, pId);
    } finally {
      _$_TarefaModelMobXStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
id: ${id},
descricao: ${descricao},
concluido: ${concluido}
    ''';
  }
}
