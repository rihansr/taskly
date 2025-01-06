part of 'dashboard_bloc.dart';

@Freezed(copyWith: true, equal: true)
class DashboardState with _$DashboardState {
  const factory DashboardState({
    ProjectModel? currentProject,
    @Default(<SectionModel, List<TaskModel>>{}) Map<SectionModel, List<TaskModel>> sectionTasks,
  }) = _DashboardState;
  
}
