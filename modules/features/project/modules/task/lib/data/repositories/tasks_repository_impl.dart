import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/network.dart';
import '../../domain/models/task_model.dart';
import '../../domain/repositories/tasks_repository.dart';
import '../data_sources/tasks_api_impl.dart';

@LazySingleton(as: TasksRepository)
class TasksRepositoryImpl extends TasksRepository {
  final TasksApiImpl tasksApi;

  TasksRepositoryImpl(
    this.tasksApi,
  );

  @override
  Future<Either<Failure, List<TaskModel>>> activeTasks(Map<String, dynamic> queryParams) async {
    try {
      final result = await tasksApi.getAllActiveTasks(queryParams);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }
  
  @override
  Future<Either<Failure, TaskModel>> singleTask(String id) async {
    try {
      final result = await tasksApi.getTaskById(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, TaskModel>> createTask(
      Map<String, dynamic> data) async {
    try {
      final result = await tasksApi.createNewTask(data);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, TaskModel>> updateTask(
      TaskModel task) async {
    try {
      final result = await tasksApi.updateTask(task);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> closeTask(String id) async {
    try {
      final result = await tasksApi.deleteTask(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> reopenTask(String id) async {
    try {
      final result = await tasksApi.deleteTask(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteTask(String id) async {
    try {
      final result = await tasksApi.deleteTask(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }
}
