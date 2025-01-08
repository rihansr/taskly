import 'package:core/configs/configs.dart';
import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/local/shared_prefs.dart';
import 'package:shared/data/data_sources/remote/network.dart';
import 'package:shared/di/service_locator.dart';
import '../../../domain/models/task_model.dart';
import 'tasks_api.dart';

@LazySingleton()
class TasksApiImpl extends TasksApi {
  TasksApiImpl();

  @override
  Future<List<TaskModel>> getAllActiveTasks(
      Map<String, dynamic> queryParams) async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"],
      endpoint: serverEnv.tasks,
      method: Method.get,
      queryParams: queryParams,
      token: sl<SharedPrefs>().token,
    );
    return TaskModel.fromJsonList(result.data ?? []);
  }

  @override
  Future<List<String>> getAllSharedLabels() async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"],
      endpoint: '${serverEnv.labels}/shared',
      method: Method.get,
      token: sl<SharedPrefs>().token,
    );
    return List<String>.from(result.data ?? []);
  }

  @override
  Future<TaskModel> getTaskById(String id) async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"],
      endpoint: "${serverEnv.tasks}/$id",
      method: Method.get,
      token: sl<SharedPrefs>().token,
    );
    return TaskModel.fromJson(result.data ?? {});
  }

  @override
  Future<TaskModel> createNewTask(Map<String, dynamic> data) async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"],
      endpoint: serverEnv.tasks,
      method: Method.post,
      token: sl<SharedPrefs>().token,
      body: data,
    );
    return TaskModel.fromJson(result.data ?? {});
  }

  @override
  Future<TaskModel> updateTask(TaskModel task) async {
    debug.print(
      task.toJson(),
      tag: 'HELL',
    );
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"],
      endpoint: "${serverEnv.tasks}/${task.id ?? "0"}",
      method: Method.post,
      token: sl<SharedPrefs>().token,
      body: task.toJson(),
    );
    return TaskModel.fromJson(result.data ?? {});
  }

  @override
  Future<bool> closeTask(String id) async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"],
      endpoint: "${serverEnv.tasks}/$id/close",
      method: Method.post,
      token: sl<SharedPrefs>().token,
    );
    return result.statusCode == 204;
  }

  @override
  Future<bool> reopenTask(String id) async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"],
      endpoint: "${serverEnv.tasks}/$id/reopen",
      method: Method.post,
      token: sl<SharedPrefs>().token,
    );
    return result.statusCode == 204;
  }

  @override
  Future<bool> deleteTask(String id) async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"],
      endpoint: "${serverEnv.tasks}/$id",
      method: Method.delete,
      token: sl<SharedPrefs>().token,
    );
    return result.statusCode == 204;
  }
}
