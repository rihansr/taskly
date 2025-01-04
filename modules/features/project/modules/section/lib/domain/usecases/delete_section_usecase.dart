import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/section_model.dart';
import '../repositories/section_repository.dart';

@LazySingleton()
class DeleteSectionUseCase {
  final SectionRepository repository;

  DeleteSectionUseCase(this.repository);

  Future<Either<Failure, bool>> invoke(SectionModel section) async {
    final result = await repository.deleteSection(section);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
