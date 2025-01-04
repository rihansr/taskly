import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/network.dart';
import '../../domain/models/comment_model.dart';
import '../../domain/repositories/comments_repository.dart';
import '../data_sources/comments_api.dart';

@LazySingleton(as: CommentsRepository)
class CommentsRepositoryImpl extends CommentsRepository {
  final CommentsApi usersApi;

  CommentsRepositoryImpl(
    this.usersApi,
  );

  @override
  Future<Either<Failure, List<CommentModel>>> allComments(
      Map<String, dynamic> queryParams) async {
    try {
      final result = await usersApi.getAllComments(queryParams);
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
      final result = await usersApi.getCommentById(id);
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
      final result = await usersApi.createNewComment(data);
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
      final result = await usersApi.updateComment(comment);
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
      final result = await usersApi.deleteComment(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }
}
