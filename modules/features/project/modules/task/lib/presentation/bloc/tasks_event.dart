part of 'tasks_bloc.dart';

@freezed
class TasksEvent with _$TasksEvent {
  const factory TasksEvent.activeTasks() = _ActiveTasks;
  const factory TasksEvent.sharedLabels() = _SharedLabels;
  const factory TasksEvent.addTask({
    required String content,
    String? description,
    required String projectId,
    required String sectionId,
     String? dueString,
     int? priority,
  }) = _AddTask;
  const factory TasksEvent.taskDetails({
    required String id,
  }) = _TaskDetails;
  const factory TasksEvent.updateTask({
    required TaskModel task,
  }) = _UpdateTask;
  const factory TasksEvent.closeTask({
    required String id,
  }) = _CloseTask;
  const factory TasksEvent.reopenTask({
    required String id,
  }) = _ReopenTask;
  const factory TasksEvent.deleteTask({
    required String id,
  }) = _DeleteTask;
}
