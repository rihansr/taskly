//@GeneratedMicroModule;ProjectPackageModule;package:project/project.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:injectable/injectable.dart' as _i526;

import 'data/data_sources/projects_api_impl.dart' as _i1034;
import 'data/repositories/projects_repository_impl.dart' as _i16;
import 'domain/repositories/projects_repository.dart' as _i182;
import 'domain/usecases/all_projects_usecase.dart' as _i775;
import 'domain/usecases/create_project_usecase.dart' as _i1015;
import 'domain/usecases/delete_project_usecase.dart' as _i177;
import 'domain/usecases/single_project_usecase.dart' as _i130;
import 'domain/usecases/update_project_usecase.dart' as _i589;

class ProjectPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.lazySingleton<_i1034.ProjectsApiImpl>(() => _i1034.ProjectsApiImpl());
    gh.lazySingleton<_i182.ProjectsRepository>(
        () => _i16.ProjectsRepositoryImpl(gh<_i1034.ProjectsApiImpl>()));
    gh.lazySingleton<_i130.SingleProjectUseCase>(
        () => _i130.SingleProjectUseCase(gh<_i182.ProjectsRepository>()));
    gh.lazySingleton<_i775.AllProjectsUseCase>(
        () => _i775.AllProjectsUseCase(gh<_i182.ProjectsRepository>()));
    gh.lazySingleton<_i177.DeleteProjectUseCase>(
        () => _i177.DeleteProjectUseCase(gh<_i182.ProjectsRepository>()));
    gh.lazySingleton<_i1015.CreateProjectUseCase>(
        () => _i1015.CreateProjectUseCase(gh<_i182.ProjectsRepository>()));
    gh.lazySingleton<_i589.UpdateProjectUseCase>(
        () => _i589.UpdateProjectUseCase(gh<_i182.ProjectsRepository>()));
  }
}
