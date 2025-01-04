import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/section_model.dart';
import '../repositories/section_repository.dart';

@LazySingleton()
class AllSectionsUseCase {
  final SectionRepository repository;

  AllSectionsUseCase(this.repository);

  Future<Either<Failure, List<SectionModel>>> invoke(Map<String, dynamic> query) async {
    final result = await repository.allSections(query);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
