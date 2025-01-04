import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/project_model.dart';
import '../repositories/project_repository.dart';

@LazySingleton()
class AllProjectsUseCase {
  final ProjectsRepository repository;

  AllProjectsUseCase(this.repository);

  Future<Either<Failure, List<ProjectModel>>> invoke() async {
    final result = await repository.allProjects();
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
