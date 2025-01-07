part of 'dashboard_bloc.dart';

@freezed
class DashboardEvent with _$DashboardEvent {
  const factory DashboardEvent.assignProject(ProjectModel? project) = _AssignProject;

  const factory DashboardEvent.addSectionTasks({
    @Default(<SectionModel>[]) List<SectionModel> sections,
    @Default(<TaskModel>[]) List<TaskModel> tasks,
  }) = _AddSectionTasks;

  const factory DashboardEvent.reset() = _Reset;
}
