class ResultadosTarefasBack4AppModel {
  List<ResultadoTarefaBack4AppModel> resultados = [];

  ResultadosTarefasBack4AppModel(this.resultados);


  ResultadosTarefasBack4AppModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      resultados = <ResultadoTarefaBack4AppModel>[];
      json['results'].forEach((v) {
        resultados.add(ResultadoTarefaBack4AppModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = resultados.map((v) => v.toJson()).toList();
    return data;
  }
}

class ResultadoTarefaBack4AppModel {
  String? objectId;
  String? descricao;
  bool? concluido;
  String? createdAt;
  String? updatedAt;

  ResultadoTarefaBack4AppModel(
      {this.objectId,
      this.descricao,
      this.concluido,
      this.createdAt,
      this.updatedAt});

  ResultadoTarefaBack4AppModel.criar(
      this.descricao, this.concluido);

  ResultadoTarefaBack4AppModel.modificar(this.objectId, this.descricao,
      this.concluido);

  ResultadoTarefaBack4AppModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    descricao = json['descricao'];
    concluido = json['concluido'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['objectId'] = this.objectId;
    data['descricao'] = this.descricao;
    data['concluido'] = this.concluido;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['descricao'] = this.descricao;
    data['concluido'] = this.concluido;

    return data;
  }
}