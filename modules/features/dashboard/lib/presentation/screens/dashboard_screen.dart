import 'package:dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:dashboard/presentation/views/projects_view.dart';
import 'package:dashboard/presentation/views/sections_view.dart';
import 'package:shared/presentation/bloc/bloc.dart';
import 'package:shared/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Backdrop(
        child: BlocConsumer<DashboardBloc, DashboardState>(
          bloc: context.watch<DashboardBloc>(),
          listener: (BuildContext context, DashboardState state) {},
          builder: (context, state) {
            return const Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 60),
                  child: SectionsView(),
                ),
                ProjectsView(),
              ],
            );
          },
        ),
      ),
    );
  }
}
