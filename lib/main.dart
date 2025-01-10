import 'package:core/core.dart';
import 'package:dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/domain/usecases/all_projects_usecase.dart';
import 'package:project/domain/usecases/create_project_usecase.dart';
import 'package:project/domain/usecases/delete_project_usecase.dart';
import 'package:project/domain/usecases/single_project_usecase.dart';
import 'package:project/domain/usecases/update_project_usecase.dart';
import 'package:project/presentation/bloc/projects_bloc.dart';
import 'package:section/domain/usecases/all_sections_usecase.dart';
import 'package:section/domain/usecases/create_section_usecase.dart';
import 'package:section/domain/usecases/delete_section_usecase.dart';
import 'package:section/domain/usecases/single_section_usecase.dart';
import 'package:section/domain/usecases/update_section_usecase.dart';
import 'package:section/presentation/bloc/sections_bloc.dart';
import 'package:task/domain/usecases/active_tasks_usecase.dart';
import 'package:task/domain/usecases/close_task_usecase.dart';
import 'package:task/domain/usecases/create_task_usecase.dart';
import 'package:task/domain/usecases/delete_task_usecase.dart';
import 'package:task/domain/usecases/reopen_task_usecase.dart';
import 'package:task/domain/usecases/single_task_usecase.dart';
import 'package:task/domain/usecases/update_task_usecase.dart';
import 'package:task/presentation/bloc/tasks_bloc.dart';
import 'package:settings/settings.dart';
import 'package:shared/di/service_locator.dart';
import 'package:shared/presentation/bloc/bloc.dart';
import 'app/di/inject.dart';
import 'app/router/routing.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Core.instance.init();
  await Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
    configureDependencies(),
  ]);
  await sl.allReady();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DashboardBloc(),
        ),
        BlocProvider(
          create: (context) => ProjectsBloc(
            sl<AllProjectsUseCase>(),
            sl<CreateProjectUseCase>(),
            sl<SingleProjectUseCase>(),
            sl<UpdateProjectUseCase>(),
            sl<DeleteProjectUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => SectionsBloc(
            sl<AllSectionsUseCase>(),
            sl<CreateSectionUseCase>(),
            sl<SingleSectionUseCase>(),
            sl<UpdateSectionUseCase>(),
            sl<DeleteSectionUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => TasksBloc(
            sl<ActiveTasksUseCase>(),
            sl<SingleTaskUseCase>(),
            sl<CreateTaskUseCase>(),
            sl<UpdateTaskUseCase>(),
            sl<CloseTaskUseCase>(),
            sl<ReopenTaskUseCase>(),
            sl<DeleteTaskUseCase>(),
          ),
        ),
      ],
      child: ValueListenableBuilder(
        valueListenable: sl<Settings>().settings,
        builder: (_, settings, __) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: settings.themeMode == ThemeMode.light
                  ? Brightness.dark
                  : Brightness.light,
            ),
          );
          return MaterialApp.router(
            title: 'Taskly',
            debugShowCheckedModeBanner: false,
            scaffoldMessengerKey: navigator.scaffoldMessengerKey,
            themeMode: settings.themeMode,
            theme: theming(ThemeMode.light),
            darkTheme: theming(ThemeMode.dark),
            locale: settings.language.locale,
            localizationsDelegates: string.delegates,
            supportedLocales: string.supportedLocales,
            routerConfig: routing,
          );
        },
      ),
    );
  }
}
