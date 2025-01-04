import 'package:comment/domain/models/comment_model.dart';
import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../repositories/comment_repository.dart';

@LazySingleton()
class AllCommentsUseCase {
  final CommentRepository repository;

  AllCommentsUseCase(this.repository);

  Future<Either<Failure, List<CommentModel>>> invoke(Map<String, dynamic> query) async {
    final result = await repository.allComments(query);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
