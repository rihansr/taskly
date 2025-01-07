part of 'projects_bloc.dart';

@freezed
class ProjectsEvent with _$ProjectsEvent {
  const factory ProjectsEvent.allProjects() = _AllProjects;
  const factory ProjectsEvent.addProject({
    required String name,
  }) = _AddProject;
  const factory ProjectsEvent.projectDetails({
    required String id,
  }) = _ProjectDetails;
  const factory ProjectsEvent.updateProject({
    required ProjectModel project,
  }) = _UpdateProject;
  const factory ProjectsEvent.deleteProject({
    required String id,
  }) = _DeleteProject;
  const factory ProjectsEvent.reset() = _Reset;
}
