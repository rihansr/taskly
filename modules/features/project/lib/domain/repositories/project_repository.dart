import 'package:core/utils/utils.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/project_model.dart';

abstract class ProjectRepository {
  Future<Either<Failure, List<ProjectModel>>> allProjects();
  Future<Either<Failure, ProjectModel>> singleProject(String id);
  Future<Either<Failure, ProjectModel>> createProject(
      Map<String, dynamic> data);
  Future<Either<Failure, ProjectModel>> updateProject(
      Map<String, dynamic> data);
  Future<Either<Failure, bool>> deleteProject(ProjectModel project);
}
