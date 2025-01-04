import 'package:core/utils/utils.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/section_model.dart';

abstract class SectionRepository {
  Future<Either<Failure, List<SectionModel>>> allSections(Map<String, dynamic> query);
  Future<Either<Failure, SectionModel>> singleSection(String id);
  Future<Either<Failure, SectionModel>> createSection(
      Map<String, dynamic> data);
  Future<Either<Failure, SectionModel>> updateSection(
      Map<String, dynamic> data);
  Future<Either<Failure, bool>> deleteSection(SectionModel section);
}
