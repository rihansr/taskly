import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/task_model.dart';
import '../repositories/tasks_repository.dart';

@LazySingleton()
class CreateTaskUseCase {
  final TasksRepository repository;

  CreateTaskUseCase(this.repository);

  Future<Either<Failure, TaskModel>> invoke(Map<String, dynamic> data) async {
    final result = await repository.createTask(data);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
