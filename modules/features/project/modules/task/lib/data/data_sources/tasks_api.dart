import '../../domain/models/task_model.dart';

abstract class TasksApi {
  Future<List<TaskModel>> getAllActiveTasks(Map<String, dynamic> queryParams);
  Future<List<String>> getAllSharedLabels();
  Future<TaskModel> getTaskById(String id);
  Future<TaskModel> createNewTask(Map<String, dynamic> data);
  Future<TaskModel> updateTask(TaskModel task);
  Future<bool> closeTask(String id);
  Future<bool> reopenTask(String id);
  Future<bool> deleteTask(String id);
}
