import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/comment_model.dart';
import '../repositories/comment_repository.dart';

@LazySingleton()
class CreateCommentUseCase {
  final CommentRepository repository;

  CreateCommentUseCase(this.repository);

  Future<Either<Failure, CommentModel>> invoke(
      Map<String, dynamic> data) async {
    final result = await repository.createComment(data);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
