import 'package:dashboard/presentation/views/projects_view.dart';
import 'package:dashboard/presentation/views/sections_view.dart';
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
    return const Scaffold(
      body: Backdrop(
          child: Stack(
        children: [
          SectionsView(),
          ProjectsView(),
        ],
      )),
    );
  }
}
