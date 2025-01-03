import 'package:comment/comment.module.dart';
import 'package:injectable/injectable.dart';
import 'package:project/project.module.dart';
import 'package:section/section.module.dart';
import 'package:settings/settings.module.dart';
import 'package:shared/di/service_locator.dart';
import 'package:shared/shared.module.dart';
import 'package:task/task.module.dart';
import 'inject.config.dart';

@InjectableInit(
  initializerName: 'init',
  throwOnMissingDependencies: true,
  externalPackageModulesBefore: [
    ExternalModule(SharedPackageModule),
    ExternalModule(SettingsPackageModule),
    ExternalModule(ProjectPackageModule),
    ExternalModule(SectionPackageModule),
    ExternalModule(TaskPackageModule),
    ExternalModule(CommentPackageModule),
  ],
)
Future<void> configureDependencies() async => sl.init();