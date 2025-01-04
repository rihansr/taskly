import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/section_model.dart';
import '../repositories/section_repository.dart';

@LazySingleton()
class UpdateSectionUseCase {
  final SectionRepository repository;

  UpdateSectionUseCase(this.repository);

  Future<Either<Failure, SectionModel>> invoke(
      Map<String, dynamic> data) async {
    final result = await repository.updateSection(data);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
