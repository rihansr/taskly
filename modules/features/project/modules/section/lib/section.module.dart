//@GeneratedMicroModule;SectionPackageModule;package:section/section.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:injectable/injectable.dart' as _i526;

import 'data/data_sources/sections_api.dart' as _i980;
import 'data/data_sources/sections_api_impl.dart' as _i729;
import 'data/repositories/sections_repository_impl.dart' as _i8;
import 'domain/repositories/sections_repository.dart' as _i142;
import 'domain/usecases/all_sections_usecase.dart' as _i1061;
import 'domain/usecases/create_section_usecase.dart' as _i963;
import 'domain/usecases/delete_section_usecase.dart' as _i702;
import 'domain/usecases/single_project_usecase.dart' as _i130;
import 'domain/usecases/update_project_usecase.dart' as _i589;

class SectionPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.lazySingleton<_i729.SectionsApiImpl>(() => _i729.SectionsApiImpl());
    gh.lazySingleton<_i142.SectionsRepository>(
        () => _i8.SectionsRepositoryImpl(gh<_i980.SectionsApi>()));
    gh.lazySingleton<_i702.DeleteSectionUseCase>(
        () => _i702.DeleteSectionUseCase(gh<_i142.SectionsRepository>()));
    gh.lazySingleton<_i130.SingleSectionUseCase>(
        () => _i130.SingleSectionUseCase(gh<_i142.SectionsRepository>()));
    gh.lazySingleton<_i963.CreateSectionUseCase>(
        () => _i963.CreateSectionUseCase(gh<_i142.SectionsRepository>()));
    gh.lazySingleton<_i1061.AllSectionsUseCase>(
        () => _i1061.AllSectionsUseCase(gh<_i142.SectionsRepository>()));
    gh.lazySingleton<_i589.UpdateSectionUseCase>(
        () => _i589.UpdateSectionUseCase(gh<_i142.SectionsRepository>()));
  }
}
