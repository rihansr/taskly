import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/comment_model.dart';
import '../repositories/comments_repository.dart';

@LazySingleton()
class UpdateCommentUseCase {
  final CommentsRepository repository;

  UpdateCommentUseCase(this.repository);

  Future<Either<Failure, CommentModel>> invoke(CommentModel comment) async {
    final result = await repository.updateComment(comment);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
