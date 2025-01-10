//@GeneratedMicroModule;TaskPackageModule;package:task/task.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:injectable/injectable.dart' as _i526;

import 'data/data_sources/tasks_api_impl.dart' as _i656;
import 'data/repositories/tasks_repository_impl.dart' as _i500;
import 'domain/repositories/tasks_repository.dart' as _i411;
import 'domain/usecases/active_tasks_usecase.dart' as _i689;
import 'domain/usecases/close_task_usecase.dart' as _i559;
import 'domain/usecases/create_task_usecase.dart' as _i612;
import 'domain/usecases/delete_task_usecase.dart' as _i757;
import 'domain/usecases/reopen_task_usecase.dart' as _i471;
import 'domain/usecases/single_task_usecase.dart' as _i236;
import 'domain/usecases/update_task_usecase.dart' as _i1018;

class TaskPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.lazySingleton<_i656.TasksApiImpl>(() => _i656.TasksApiImpl());
    gh.lazySingleton<_i411.TasksRepository>(
        () => _i500.TasksRepositoryImpl(gh<_i656.TasksApiImpl>()));
    gh.lazySingleton<_i1018.UpdateTaskUseCase>(
        () => _i1018.UpdateTaskUseCase(gh<_i411.TasksRepository>()));
    gh.lazySingleton<_i559.CloseTaskUseCase>(
        () => _i559.CloseTaskUseCase(gh<_i411.TasksRepository>()));
    gh.lazySingleton<_i757.DeleteTaskUseCase>(
        () => _i757.DeleteTaskUseCase(gh<_i411.TasksRepository>()));
    gh.lazySingleton<_i236.SingleTaskUseCase>(
        () => _i236.SingleTaskUseCase(gh<_i411.TasksRepository>()));
    gh.lazySingleton<_i612.CreateTaskUseCase>(
        () => _i612.CreateTaskUseCase(gh<_i411.TasksRepository>()));
    gh.lazySingleton<_i689.ActiveTasksUseCase>(
        () => _i689.ActiveTasksUseCase(gh<_i411.TasksRepository>()));
    gh.lazySingleton<_i471.ReopenTaskUseCase>(
        () => _i471.ReopenTaskUseCase(gh<_i411.TasksRepository>()));
  }
}
