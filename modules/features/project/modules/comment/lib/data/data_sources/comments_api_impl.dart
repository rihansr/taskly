import 'package:core/configs/configs.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/local/shared_prefs.dart';
import 'package:shared/data/data_sources/remote/network.dart';
import 'package:shared/di/service_locator.dart';
import '../../../domain/models/comment_model.dart';
import 'comments_api.dart';

@LazySingleton()
class CommentsApiImpl extends CommentsApi {
  CommentsApiImpl();

  @override
  Future<List<CommentModel>> getAllComments(
      Map<String, dynamic> queryParams) async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"],
      endpoint: serverEnv.comments,
      method: Method.get,
      queryParams: queryParams,
      token: sl<SharedPrefs>().token,
    );
    return CommentModel.fromJsonList(result.data ?? []);
  }

  @override
  Future<CommentModel> getCommentById(String id) async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"],
      endpoint: "${serverEnv.comments}/$id",
      method: Method.get,
      token: sl<SharedPrefs>().token,
    );
    return CommentModel.fromJson(result.data ?? {});
  }

  @override
  Future<CommentModel> createNewComment(Map<String, dynamic> data) async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"],
      endpoint: serverEnv.comments,
      method: Method.post,
      token: sl<SharedPrefs>().token,
      body: data,
    );
    return CommentModel.fromJson(result.data ?? {});
  }

  @override
  Future<CommentModel> updateComment(CommentModel comment) async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"],
      endpoint: "${serverEnv.comments}/${comment.id ?? "0"}",
      method: Method.post,
      token: sl<SharedPrefs>().token,
      body: comment.toJson()..removeWhere((key, value) => value == null),
    );
    return CommentModel.fromJson(result.data ?? {});
  }

  @override
  Future<bool> deleteComment(String id) async {
    final result = await sl<ApiHandler>().invoke(
      baseUrl: appConfig.config["base_url"],
      endpoint: "${serverEnv.comments}/$id",
      method: Method.delete,
      token: sl<SharedPrefs>().token,
    );
    return result.statusCode == 204;
  }
}
