import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../repositories/comments_repository.dart';

@LazySingleton()
class DeleteCommentUseCase {
  final CommentsRepository repository;

  DeleteCommentUseCase(this.repository);

  Future<Either<Failure, bool>> invoke(String id) async {
    final result = await repository.deleteComment(id);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
