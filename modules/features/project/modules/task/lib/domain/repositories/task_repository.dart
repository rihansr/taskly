import 'package:core/utils/utils.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/task_model.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<TaskModel>>> activeTasks();
  Future<Either<Failure, TaskModel>> singleTask(String id);
  Future<Either<Failure, TaskModel>> createTask(Map<String, dynamic> data);
  Future<Either<Failure, TaskModel>> updateTask(Map<String, dynamic> data);
  Future<Either<Failure, bool>> reopenTask(TaskModel task);
  Future<Either<Failure, bool>> closeTask(TaskModel task);
  Future<Either<Failure, bool>> deleteTask(TaskModel task);
}
