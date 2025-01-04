import 'package:core/utils/utils.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/task_model.dart';

abstract class TasksRepository {
  Future<Either<Failure, List<TaskModel>>> activeTasks();
  Future<Either<Failure, List<String>>> sharedLabels();
  Future<Either<Failure, TaskModel>> singleTask(String id);
  Future<Either<Failure, TaskModel>> createTask(Map<String, dynamic> data);
  Future<Either<Failure, TaskModel>> updateTask(TaskModel task);
  Future<Either<Failure, bool>> closeTask(String id);
  Future<Either<Failure, bool>> reopenTask(String id);
  Future<Either<Failure, bool>> deleteTask(String id);
}
