import 'package:project/presentation/bloc/projects_bloc.dart';
import 'package:shared/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/bloc/bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    context.read<ProjectsBloc>().add(const ProjectsEvent.allProjects());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        centerTitle: false,
        titleTextStyle: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Backdrop(
        child: SafeArea(
          child: Container(),
        ),
      ),
    );
  }
}
