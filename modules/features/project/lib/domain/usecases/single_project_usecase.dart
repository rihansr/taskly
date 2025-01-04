import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/project_model.dart';
import '../repositories/project_repository.dart';

@LazySingleton()
class SingleProjectUseCase {
  final ProjectsRepository repository;

  SingleProjectUseCase(this.repository);

  Future<Either<Failure, ProjectModel>> invoke(String id) async {
    final result = await repository.singleProject(id);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
