import 'package:core/utils/utils.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/comment_model.dart';

abstract class CommentsRepository {
  Future<Either<Failure, List<CommentModel>>> allComments(
      Map<String, dynamic> queryParams);
  Future<Either<Failure, CommentModel>> singleComment(String id);
  Future<Either<Failure, CommentModel>> createComment(
      Map<String, dynamic> data);
  Future<Either<Failure, CommentModel>> updateComment(
      CommentModel comment);
  Future<Either<Failure, bool>> deleteComment(String id);
}
