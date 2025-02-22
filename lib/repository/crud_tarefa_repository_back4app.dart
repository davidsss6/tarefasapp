import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:listatarefasapp/interceptors/back4app_dio_interceptor.dart';
import 'package:listatarefasapp/models/dados_tarefa_back4app_model.dart';

class CrudTarefaBack4AppRepository {
  var _dio = Dio();

  CrudTarefaBack4AppRepository() {
    _dio = Dio();
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("BACK4APP_BASEURL");
    _dio.interceptors.add(Back4AppDioInterceptor());
  }

  Future<ResultadosTarefasBack4AppModel> obterTarefa() async {
    var url = "/Tarefas";
    var result = await _dio.get(url);
    return ResultadosTarefasBack4AppModel.fromJson(result.data);
  }

  Future<ResultadosTarefasBack4AppModel> obterTarefaNaoConcluidas() async {
    var url = "/Tarefas?where={\"concluido\":false}";
    var result = await _dio.get(url);
    return ResultadosTarefasBack4AppModel.fromJson(result.data);
  }

  Future<void> criarTarefa(
      ResultadoTarefaBack4AppModel dadoTarefaBack4AppModel) async {
    try {
      await _dio.post("/Tarefas",
          data: dadoTarefaBack4AppModel.toJsonEndpoint());
    } catch (e) {
      throw e;
    }
  }

  Future<void> atualizarTarefa(
      ResultadoTarefaBack4AppModel dadoCepBack4AppModel) async {
    print(dadoCepBack4AppModel.objectId.toString());

    try {
      await _dio.put("/Tarefas/" + dadoCepBack4AppModel.objectId.toString(),
          data: dadoCepBack4AppModel.toJsonEndpoint());
    } catch (e) {
      throw e;
    }
  }

  Future<void> removerContato(String objectId) async {
    try {
      await _dio.delete("/Tarefas/$objectId");
    } catch (e) {
      throw e;
    }
  }
}
