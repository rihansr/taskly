import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/task_model.dart';
import '../repositories/tasks_repository.dart';

@LazySingleton()
class UpdateTaskUseCase {
  final TasksRepository repository;

  UpdateTaskUseCase(this.repository);

  Future<Either<Failure, TaskModel>> invoke(TaskModel task) async {
    final result = await repository.updateTask(task);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
