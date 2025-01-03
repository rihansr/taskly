// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:comment/comment.module.dart' as _i881;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:project/project.module.dart' as _i383;
import 'package:section/section.module.dart' as _i507;
import 'package:settings/settings.module.dart' as _i82;
import 'package:shared/shared.module.dart' as _i17;
import 'package:task/task.module.dart' as _i640;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    await _i17.SharedPackageModule().init(gh);
    await _i82.SettingsPackageModule().init(gh);
    await _i383.ProjectPackageModule().init(gh);
    await _i507.SectionPackageModule().init(gh);
    await _i640.TaskPackageModule().init(gh);
    await _i881.CommentPackageModule().init(gh);
    return this;
  }
}
