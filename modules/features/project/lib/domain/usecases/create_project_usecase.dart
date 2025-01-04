import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/project_model.dart';
import '../repositories/projects_repository.dart';

@LazySingleton()
class CreateProjectUseCase {
  final ProjectsRepository repository;

  CreateProjectUseCase(this.repository);

  Future<Either<Failure, ProjectModel>> invoke(
      Map<String, dynamic> data) async {
    final result = await repository.createProject(data);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
