import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../repositories/projects_repository.dart';

@LazySingleton()
class DeleteProjectUseCase {
  final ProjectsRepository repository;

  DeleteProjectUseCase(this.repository);

  Future<Either<Failure, bool>> invoke(String id) async {
    final result = await repository.deleteProject(id);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
