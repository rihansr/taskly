import 'package:core/configs/configs.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/local/shared_prefs.dart';
import 'package:shared/data/data_sources/remote/network.dart';
import 'package:shared/di/service_locator.dart';
import '../../domain/models/project_model.dart';
import 'projects_api.dart';

@LazySingleton()
class ProjectsApiImpl extends ProjectsApi {
  ProjectsApiImpl();

  @override
  Future<List<ProjectModel>> getAllProjects() async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"],
      endpoint: serverEnv.projects,
      method: Method.get,
      token: sl<SharedPrefs>().token,
    );
    return ProjectModel.fromJsonList(result.data ?? []);
  }

  @override
  Future<ProjectModel> getProjectById(String id) async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"],
      endpoint: "${serverEnv.projects}/$id",
      method: Method.get,
      token: sl<SharedPrefs>().token,
    );
    return ProjectModel.fromJson(result.data ?? {});
  }

  @override
  Future<ProjectModel> createNewProject(Map<String, dynamic> data) async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"],
      endpoint: serverEnv.projects,
      method: Method.post,
      token: sl<SharedPrefs>().token,
      body: data,
    );
    return ProjectModel.fromJson(result.data ?? {});
  }

  @override
  Future<ProjectModel> updateProject(ProjectModel project) async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"],
      endpoint: "${serverEnv.projects}/${project.id ?? "0"}",
      method: Method.put,
      token: sl<SharedPrefs>().token,
      body: project.toJson(),
    );
    return ProjectModel.fromJson(result.data ?? {});
  }

  @override
  Future<bool> deleteProject(String id) async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"],
      endpoint: "${serverEnv.projects}/$id",
      method: Method.delete,
      token: sl<SharedPrefs>().token,
    );
    return result.statusCode == 204;
  }
}
