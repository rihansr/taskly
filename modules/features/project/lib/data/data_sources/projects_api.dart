import '../../domain/models/project_model.dart';

abstract class ProjectsApi {
  Future<List<ProjectModel>> getAllProjects();
  Future<ProjectModel> getProjectById(String id);
  Future<ProjectModel> createNewProject(Map<String, dynamic> data);
  Future<ProjectModel> updateProject(ProjectModel project);
  Future<bool> deleteProject(String id);
}
