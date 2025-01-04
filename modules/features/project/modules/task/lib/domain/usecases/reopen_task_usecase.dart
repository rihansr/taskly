import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/task_model.dart';
import '../repositories/task_repository.dart';

@LazySingleton()
class ReopenTaskUseCase {
  final TaskRepository repository;

  ReopenTaskUseCase(this.repository);

  Future<Either<Failure, bool>> invoke(TaskModel task) async {
    final result = await repository.reopenTask(task);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
