import 'package:core/styles/dimen.dart';
import 'package:core/styles/style.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:project/domain/models/project_model.dart';
import 'package:project/presentation/bloc/projects_bloc.dart';
import 'package:project/presentation/views/add_project_view.dart';
import 'package:section/presentation/bloc/sections_bloc.dart';
import 'package:shared/data/data_sources/local/shared_prefs.dart';
import 'package:shared/di/service_locator.dart';
import 'package:shared/presentation/bloc/bloc.dart';
import 'package:shared/presentation/widgets/widgets.dart';
import 'package:task/presentation/bloc/tasks_bloc.dart';
import '../bloc/dashboard_bloc.dart';
import '../components/add_project_button.dart';
import '../components/project_list_tile.dart';

class ProjectsView extends StatefulWidget {
  const ProjectsView({super.key});

  @override
  ProjectsViewState createState() {
    return ProjectsViewState();
  }
}

class ProjectsViewState extends State<ProjectsView>
    with SingleTickerProviderStateMixin {
  double minWidth = 64;
  bool isCollapsed = false;
  late AnimationController _animationController;
  late Animation<double> widthAnimation;

  _toggle() {
    setState(() {
      isCollapsed = !isCollapsed;
      isCollapsed
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }

  fetchAllSections(BuildContext context, ProjectsState state,
      [ProjectModel? project]) {
    final dashboard = context.read<DashboardBloc>();
    var tasks = dashboard.state.sectionTasks;
    var currentProject = project ??
        dashboard.state.currentProject ??
        (() {
          final currentProject = sl<SharedPrefs>().currentProject;
          return currentProject != null
              ? ProjectModel.fromJson(currentProject)
              : state.projects.firstOrNull;
        }());

    if (state.projects.isEmpty) {
      if (currentProject != null) dashboard.add(const DashboardEvent.reset());
      if (tasks.isNotEmpty) {
        context.read<SectionsBloc>().add(const SectionsEvent.reset());
        context.read<TasksBloc>().add(const TasksEvent.reset());
      }
    } else {
      if (!state.projects.contains(currentProject)) {
        currentProject = state.projects.firstOrNull;
      }
      dashboard.add(DashboardEvent.assignProject(currentProject));

      if (currentProject?.id == null) return;
      context
          .read<SectionsBloc>()
          .add(SectionsEvent.allSections(projectId: currentProject!.id!));
      if (!isCollapsed) _toggle();
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: kDefaultDuration);
    widthAnimation = Tween<double>(begin: dimen.width * .6, end: minWidth)
        .animate(_animationController);
    context.read<ProjectsBloc>().add(const ProjectsEvent.allProjects());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.scaffoldBackgroundColor;
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) => Container(
        width: widthAnimation.value,
        height: double.infinity,
        padding: EdgeInsets.only(top: dimen.padding.top),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              backgroundColor,
              backgroundColor.withOpacity(0.95),
              backgroundColor.withOpacity(0.85),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: _toggle,
                child: Container(
                  width: 60,
                  height: 60,
                  alignment: Alignment.center,
                  child: AnimatedIcon(
                    icon: AnimatedIcons.close_menu,
                    progress: _animationController,
                    size: 32.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Flexible(
              child: BlocConsumer<ProjectsBloc, ProjectsState>(
                bloc: context.watch<ProjectsBloc>(),
                listener: (context, state) {
                  if (state.status != Status.success) return;
                  fetchAllSections(context, state);
                },
                builder: (context, state) {
                  if (state.projects.isEmpty &&
                      state.status == Status.loading) {
                    return Skeletonizer(
                      enabled: true,
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 24),
                        separatorBuilder: (context, counter) {
                          return const Divider();
                        },
                        itemBuilder: (context, counter) => CollapsingListTile(
                          title: 'Unknown',
                          animationController: _animationController,
                        ),
                        itemCount: 5,
                      ),
                    );
                  } else {
                    return ListView.separated(
                      padding: const EdgeInsets.only(bottom: 24),
                      shrinkWrap: true,
                      separatorBuilder: (context, counter) {
                        return const Divider();
                      },
                      itemBuilder: (context, counter) {
                        final project = state.projects[counter];
                        return CollapsingListTile(
                          onTap: () =>
                              fetchAllSections(context, state, project),
                          onEdit: () => showModalBottomSheet(
                            context: context,
                            enableDrag: true,
                            showDragHandle: true,
                            shape: style.defaultBottomSheetShape,
                            builder: (_) => AddProjectView(project: project),
                          ).then(
                            (project) {
                              if (project != null) {
                                context.read<ProjectsBloc>().add(
                                      ProjectsEvent.updateProject(
                                        project: project as ProjectModel,
                                      ),
                                    );
                              }
                            },
                          ),
                          onDelete: () {
                            context.read<ProjectsBloc>().add(
                                  ProjectsEvent.deleteProject(
                                    id: project.id ?? '',
                                  ),
                                );
                          },
                          isSelected: context
                                  .watch<DashboardBloc>()
                                  .state
                                  .currentProject
                                  ?.id ==
                              project.id,
                          title: project.name ?? 'Unknown',
                          animationController: _animationController,
                        );
                      },
                      itemCount: state.projects.length,
                    );
                  }
                },
              ),
            ),
            AddProjectButton(
              animationController: _animationController,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
