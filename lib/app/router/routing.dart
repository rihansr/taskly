import 'package:core/router/routes.dart';
import 'package:core/service/navigation_service.dart';
import 'package:dashboard/presentation/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/presentation/widgets/widgets.dart';
import 'package:splash/splash.dart';

final GoRouter routing = GoRouter(
  navigatorKey: navigator.navigatorKey,
  initialLocation: Routes.splash,
  routes: <RouteBase>[
    GoRoute(
      name: Routes.splash,
      path: Routes.splash,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      name: Routes.dashboard,
      path: Routes.dashboard,
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardScreen();
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(),
    extendBodyBehindAppBar: true,
    extendBody: true,
    body: const Backdrop(
      child: Center(
        child: Text('Page not found'),
      ),
    ),
  ),
);
