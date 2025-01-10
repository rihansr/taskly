part of 'tasks_bloc.dart';

@freezed
class TasksEvent with _$TasksEvent {
  const factory TasksEvent.activeTasks(
    {required String projectId}
  ) = _ActiveTasks;
  const factory TasksEvent.addTask({
    required TaskModel task,
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
  const factory TasksEvent.reset() = _Reset;
}
