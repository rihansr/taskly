import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/project_model.dart';
import '../repositories/project_repository.dart';

@LazySingleton()
class UpdateProjectUseCase {
  final ProjectsRepository repository;

  UpdateProjectUseCase(this.repository);

  Future<Either<Failure, ProjectModel>> invoke(ProjectModel project) async {
    final result = await repository.updateProject(project);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
