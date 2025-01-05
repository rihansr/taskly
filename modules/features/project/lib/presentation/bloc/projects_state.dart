part of 'projects_bloc.dart';

@Freezed(copyWith: true, equal: true)
class ProjectsState with _$ProjectsState {
  const factory ProjectsState({
    @Default(Status.initial) Status status,
    String? errorMessage,
    @Default(<ProjectModel>[]) List<ProjectModel> projects,
    @Default(ProjectModel()) ProjectModel project,
  }) = _ProjectsState;
}
