part of 'projects_bloc.dart';

enum Status { initial, loading, creating, updating, deleting, success, failure }

@Freezed(copyWith: true, equal: true)
class ProjectsState with _$ProjectsState {
  const factory ProjectsState({
    @Default(Status.initial) Status status,
    String? errorMessage,
    @Default(<ProjectModel>[]) List<ProjectModel> projects,
    @Default(ProjectModel()) ProjectModel project,
  }) = _ProjectsState;
}