import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../repositories/tasks_repository.dart';

@LazySingleton()
class SharedLabelsUseCase {
  final TasksRepository repository;

  SharedLabelsUseCase(this.repository);

  Future<Either<Failure, List<String>>> invoke() async {
    final result = await repository.sharedLabels();
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
