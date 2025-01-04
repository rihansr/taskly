part of 'tasks_bloc.dart';

enum Status { initial, loading, creating, updating, reopening, closing, deleting, success, failure }

@Freezed(copyWith: true, equal: true)
class TasksState with _$TasksState {
  const factory TasksState({
    @Default(Status.initial) Status status,
    String? errorMessage,
    @Default(<TaskModel>[]) List<TaskModel> tasks,
    @Default(TaskModel()) TaskModel task,
    @Default(<String>[]) List<String> labels,
  }) = _TasksState;
}
