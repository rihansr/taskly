import 'package:core/configs/configs.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/local/shared_prefs.dart';
import 'package:shared/data/data_sources/remote/network.dart';
import 'package:shared/di/service_locator.dart';
import '../../../domain/models/section_model.dart';
import 'sections_api.dart';

@LazySingleton()
class SectionsApiImpl extends SectionsApi {
  SectionsApiImpl();

  @override
  Future<List<SectionModel>> getAllProjectSections(
      Map<String, dynamic> queryParams) async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"],
      endpoint: serverEnv.sections,
      method: Method.get,
      queryParams: queryParams,
      token: sl<SharedPrefs>().token,
    );
    return SectionModel.fromJsonList(result.data ?? []);
  }

  @override
  Future<SectionModel> getSectionById(String id) async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"],
      endpoint: "${serverEnv.sections}/$id",
      method: Method.get,
      token: sl<SharedPrefs>().token,
    );
    return SectionModel.fromJson(result.data ?? {});
  }

  @override
  Future<SectionModel> createNewSection(Map<String, dynamic> data) async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"],
      endpoint: serverEnv.sections,
      method: Method.post,
      token: sl<SharedPrefs>().token,
      body: data,
    );
    return SectionModel.fromJson(result.data ?? {});
  }

  @override
  Future<SectionModel> updateSection(SectionModel section) async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"],
      endpoint: "${serverEnv.sections}/${section.id ?? "0"}",
      method: Method.post,
      token: sl<SharedPrefs>().token,
      body: section.toJson()..removeWhere((key, value) => value == null),
    );
    return SectionModel.fromJson(result.data ?? {});
  }

  @override
  Future<bool> deleteSection(String id) async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"],
      endpoint: "${serverEnv.sections}/$id",
      method: Method.delete,
      token: sl<SharedPrefs>().token,
    );
    return result.statusCode == 204;
  }
}
