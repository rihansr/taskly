import 'package:core/utils/utils.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/project_model.dart';

abstract class ProjectsRepository {
  Future<Either<Failure, List<ProjectModel>>> allProjects();
  Future<Either<Failure, ProjectModel>> singleProject(String id);
  Future<Either<Failure, ProjectModel>> createProject(
      Map<String, dynamic> data);
  Future<Either<Failure, ProjectModel>> updateProject(ProjectModel project);
  Future<Either<Failure, bool>> deleteProject(String id);
}
