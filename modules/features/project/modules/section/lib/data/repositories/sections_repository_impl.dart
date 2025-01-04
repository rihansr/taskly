import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/network.dart';
import '../../domain/models/section_model.dart';
import '../../domain/repositories/sections_repository.dart';
import '../data_sources/sections_api.dart';

@LazySingleton(as: SectionsRepository)
class SectionsRepositoryImpl extends SectionsRepository {
  final SectionsApi usersApi;

  SectionsRepositoryImpl(
    this.usersApi,
  );

  @override
  Future<Either<Failure, List<SectionModel>>> allSections(
      Map<String, dynamic> queryParams) async {
    try {
      final result = await usersApi.getAllProjectSections(queryParams);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, SectionModel>> singleSection(String id) async {
    try {
      final result = await usersApi.getSectionById(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, SectionModel>> createSection(
      Map<String, dynamic> data) async {
    try {
      final result = await usersApi.createNewSection(data);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, SectionModel>> updateSection(
      SectionModel section) async {
    try {
      final result = await usersApi.updateSection(section);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteSection(String id) async {
    try {
      final result = await usersApi.deleteSection(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }
}
