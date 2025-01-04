import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/network.dart';
import '../../domain/models/project_model.dart';
import '../../domain/repositories/project_repository.dart';
import '../data_sources/projects_api.dart';

@LazySingleton(as: ProjectsRepository)
class ProjectsRepositoryImpl extends ProjectsRepository {
  final ProjectsApi usersApi;

  ProjectsRepositoryImpl(
    this.usersApi,
  );

  @override
  Future<Either<Failure, List<ProjectModel>>> allProjects() async {
    try {
      final result = await usersApi.getAllProjects();
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
      final result = await usersApi.getProjectById(id);
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
      final result = await usersApi.createNewProject(data);
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
      final result = await usersApi.updateProject(project);
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
      final result = await usersApi.deleteProject(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }
}
