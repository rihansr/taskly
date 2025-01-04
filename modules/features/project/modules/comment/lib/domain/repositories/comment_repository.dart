import 'package:core/utils/utils.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/comment_model.dart';

abstract class CommentRepository {
  Future<Either<Failure, List<CommentModel>>> allComments(Map<String, dynamic> query);
  Future<Either<Failure, CommentModel>> singleComment(String id);
  Future<Either<Failure, CommentModel>> createComment(
      Map<String, dynamic> data);
  Future<Either<Failure, CommentModel>> updateComment(
      Map<String, dynamic> data);
  Future<Either<Failure, bool>> deleteComment(CommentModel comment);
}
