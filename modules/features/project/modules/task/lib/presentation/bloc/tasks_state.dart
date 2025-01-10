part of 'tasks_bloc.dart';

@Freezed(copyWith: true, equal: true)
class TasksState with _$TasksState {
  const factory TasksState({
    @Default(Status.initial) Status status,
    String? errorMessage,
    @Default(<TaskModel>[]) List<TaskModel> tasks,
    @Default(TaskModel()) TaskModel task,
  }) = _TasksState;
}
