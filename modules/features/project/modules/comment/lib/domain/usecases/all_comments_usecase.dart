import 'package:comment/domain/models/comment_model.dart';
import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../repositories/comments_repository.dart';

@LazySingleton()
class AllCommentsUseCase {
  final CommentsRepository repository;

  AllCommentsUseCase(this.repository);

  Future<Either<Failure, List<CommentModel>>> invoke(
      Map<String, dynamic> queryParams) async {
    final result = await repository.allComments(queryParams);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
