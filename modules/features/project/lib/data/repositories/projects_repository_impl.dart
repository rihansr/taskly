import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:project/data/data_sources/projects_api_impl.dart';
import 'package:shared/data/data_sources/remote/network.dart';
import '../../domain/models/project_model.dart';
import '../../domain/repositories/projects_repository.dart';

@LazySingleton(as: ProjectsRepository)
class ProjectsRepositoryImpl extends ProjectsRepository {
  final ProjectsApiImpl projectsApi;

  ProjectsRepositoryImpl(this.projectsApi);

  @override
  Future<Either<Failure, List<ProjectModel>>> allProjects() async {
    try {
      final result = await projectsApi.getAllProjects();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, ProjectModel>> singleProject(String id) async {
    try {
      final result = await projectsApi.getProjectById(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, ProjectModel>> createProject(
      Map<String, dynamic> data) async {
    try {
      final result = await projectsApi.createNewProject(data);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, ProjectModel>> updateProject(
      ProjectModel project) async {
    try {
      final result = await projectsApi.updateProject(project);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteProject(String id) async {
    try {
      final result = await projectsApi.deleteProject(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }
}
