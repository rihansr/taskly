import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/section_model.dart';
import '../repositories/sections_repository.dart';

@LazySingleton()
class UpdateSectionUseCase {
  final SectionsRepository repository;

  UpdateSectionUseCase(this.repository);

  Future<Either<Failure, SectionModel>> invoke(SectionModel section) async {
    final result = await repository.updateSection(section);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
