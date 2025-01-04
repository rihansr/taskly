import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/section_model.dart';
import '../repositories/sections_repository.dart';

@LazySingleton()
class SingleSectionUseCase {
  final SectionsRepository repository;

  SingleSectionUseCase(this.repository);

  Future<Either<Failure, SectionModel>> invoke(String id) async {
    final result = await repository.singleSection(id);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
