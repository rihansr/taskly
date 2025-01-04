import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../repositories/sections_repository.dart';

@LazySingleton()
class DeleteSectionUseCase {
  final SectionsRepository repository;

  DeleteSectionUseCase(this.repository);

  Future<Either<Failure, bool>> invoke(String id) async {
    final result = await repository.deleteSection(id);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
