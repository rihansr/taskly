import 'package:core/styles/dimen.dart';
import 'package:core/styles/style.dart';
import 'package:core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:project/domain/models/project_model.dart';
import 'package:project/presentation/bloc/projects_bloc.dart';
import 'package:project/presentation/views/add_project_view.dart';
import 'package:section/presentation/bloc/sections_bloc.dart';
import 'package:shared/presentation/bloc/bloc.dart';
import 'package:shared/presentation/widgets/widgets.dart';
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

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
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
              backgroundColor.withOpacity(0.75),
              backgroundColor.withOpacity(0),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isCollapsed = !isCollapsed;
                    isCollapsed
                        ? _animationController.forward()
                        : _animationController.reverse();
                  });
                },
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
                  final dashboard = context.read<DashboardBloc>();
                  final currentProject = dashboard.state.currentProject;
                  if (state.status == Status.success) {
                    if (state.projects.isNotEmpty) {
                      if (currentProject == null ||
                          !state.projects.contains(currentProject)) {
                        dashboard.add(
                          DashboardEvent.assignProject(state.projects.first),
                        );
                      }

                      String by = currentProject?.id ?? '';
                      context
                          .read<SectionsBloc>()
                          .add(SectionsEvent.allSections(projectId: by));
                    } else {
                      dashboard.add(
                        const DashboardEvent.assignProject(null),
                      );
                    }
                  }
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
                          onTap: () {
                            final dashboard = context.read<DashboardBloc>();
                            dashboard.add(
                              DashboardEvent.assignProject(project),
                            );
                            final currentProject = dashboard.state.currentProject;
                            String by = currentProject?.id ?? '';
                            context
                                .read<SectionsBloc>()
                                .add(SectionsEvent.allSections(projectId: by));
                          },
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
