import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/network.dart';
import '../../domain/models/comment_model.dart';
import '../../domain/repositories/comments_repository.dart';
import '../data_sources/comments_api_impl.dart';

@LazySingleton(as: CommentsRepository)
class CommentsRepositoryImpl extends CommentsRepository {
  final CommentsApiImpl commentsApi;

  CommentsRepositoryImpl(this.commentsApi);

  @override
  Future<Either<Failure, List<CommentModel>>> allComments(
      Map<String, dynamic> queryParams) async {
    try {
      final result = await commentsApi.getAllComments(queryParams);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, CommentModel>> singleComment(String id) async {
    try {
      final result = await commentsApi.getCommentById(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, CommentModel>> createComment(
      Map<String, dynamic> data) async {
    try {
      final result = await commentsApi.createNewComment(data);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, CommentModel>> updateComment(
      CommentModel comment) async {
    try {
      final result = await commentsApi.updateComment(comment);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteComment(String id) async {
    try {
      final result = await commentsApi.deleteComment(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }
}
