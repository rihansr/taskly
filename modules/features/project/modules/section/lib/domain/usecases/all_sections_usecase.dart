import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/section_model.dart';
import '../repositories/sections_repository.dart';

@LazySingleton()
class AllSectionsUseCase {
  final SectionsRepository repository;

  AllSectionsUseCase(this.repository);

  Future<Either<Failure, List<SectionModel>>> invoke(
      Map<String, dynamic> queryParams) async {
    final result = await repository.allSections(queryParams);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
