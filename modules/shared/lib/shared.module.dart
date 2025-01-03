//@GeneratedMicroModule;SharedPackageModule;package:shared/shared.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:dio/dio.dart' as _i361;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import 'data/data_sources/local/shared_prefs.dart' as _i1004;
import 'data/data_sources/remote/api_handler.dart' as _i256;
import 'di/modules/dio_client_module.dart' as _i999;
import 'di/modules/shared_preferences_module.dart' as _i676;

class SharedPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) async {
    final dioClientModule = _$DioClientModule();
    final sharedPreferencesModule = _$SharedPreferencesModule();
    gh.singleton<_i361.Dio>(() => dioClientModule.dio());
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => sharedPreferencesModule.createSharedPreferences(),
      preResolve: true,
    );
    gh.singleton<_i1004.SharedPrefs>(() => _i1004.SharedPrefs());
    gh.singleton<_i256.ApiHandler>(() => _i256.ApiHandler());
  }
}

class _$DioClientModule extends _i999.DioClientModule {}

class _$SharedPreferencesModule extends _i676.SharedPreferencesModule {}
