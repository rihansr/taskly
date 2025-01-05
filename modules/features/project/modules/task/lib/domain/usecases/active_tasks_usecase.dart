import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/task_model.dart';
import '../repositories/tasks_repository.dart';

@LazySingleton()
class ActiveTasksUseCase {
  final TasksRepository repository;

  ActiveTasksUseCase(this.repository);

  Future<Either<Failure, List<TaskModel>>> invoke(Map<String, dynamic> queryParams) async {
    final result = await repository.activeTasks(queryParams);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
