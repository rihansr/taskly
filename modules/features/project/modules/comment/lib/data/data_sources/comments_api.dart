import '../../domain/models/comment_model.dart';

abstract class CommentsApi {
  Future<List<CommentModel>> getAllComments(Map<String, dynamic> queryParams);
  Future<CommentModel> getCommentById(String id);
  Future<CommentModel> createNewComment(Map<String, dynamic> data);
  Future<CommentModel> updateComment(CommentModel comment);
  Future<bool> deleteComment(String id);
}
