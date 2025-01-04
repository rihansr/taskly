import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../repositories/tasks_repository.dart';

@LazySingleton()
class DeleteTaskUseCase {
  final TasksRepository repository;

  DeleteTaskUseCase(this.repository);

  Future<Either<Failure, bool>> invoke(String id) async {
    final result = await repository.deleteTask(id);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
