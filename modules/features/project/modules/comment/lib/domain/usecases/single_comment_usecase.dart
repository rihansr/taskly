import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/comment_model.dart';
import '../repositories/comment_repository.dart';

@LazySingleton()
class SingleCommentUseCase {
  final CommentRepository repository;

  SingleCommentUseCase(this.repository);

  Future<Either<Failure, CommentModel>> invoke(String id) async {
    final result = await repository.singleComment(id);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
