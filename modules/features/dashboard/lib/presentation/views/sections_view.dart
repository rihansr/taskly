import 'package:core/styles/drawable.dart';
import 'package:core/styles/style.dart';
import 'package:core/utils/enums.dart';
import 'package:core/utils/extensions/extensions.dart';
import 'package:core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:section/domain/models/section_model.dart';
import 'package:section/presentation/bloc/sections_bloc.dart';
import 'package:section/presentation/views/add_section_view.dart';
import 'package:shared/presentation/bloc/bloc.dart';
import 'package:shared/presentation/widgets/widgets.dart';
import 'package:task/presentation/bloc/tasks_bloc.dart';
import '../bloc/dashboard_bloc.dart';
import 'tasks_board_view.dart';

class SectionsView extends StatefulWidget {
  const SectionsView({super.key});

  @override
  State<SectionsView> createState() => _SectionsViewState();
}

class _SectionsViewState extends State<SectionsView> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          primary: true,
          pinned: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () => context.router.pushNamed(Routes.settings),
            ),
            IconButton(
              icon: const Icon(Icons.add, size: 28),
              onPressed: () => showModalBottomSheet(
                context: context,
                enableDrag: true,
                showDragHandle: true,
                shape: style.defaultBottomSheetShape,
                builder: (_) => AddSectionView(
                  projectID:
                      context.read<DashboardBloc>().state.currentProject?.id ??
                          '',
                ),
              ).then(
                (section) {
                  if (section != null) {
                    context.read<SectionsBloc>().add(
                          SectionsEvent.addSection(
                            projectId:
                                (section as SectionModel?)?.projectId ?? '',
                            name: section?.name ?? '',
                          ),
                        );
                  }
                },
              ),
            ),
          ],
        ),
      ],
      body: BlocConsumer<SectionsBloc, SectionsState>(
        bloc: context.read<SectionsBloc>(),
        listener: (context, state) {
          if (state.status == Status.success) {
            context.read<TasksBloc>().add(
                  TasksEvent.activeTasks(
                      projectId: context
                              .read<DashboardBloc>()
                              .state
                              .currentProject
                              ?.id ??
                          ''),
                );
          }
        },
        builder: (context, state) {
          if (state.sections.isEmpty && state.status == Status.loading) {
            return Center(
              child: LottieBuilder.asset(
                drawable.loading,
                width: 72,
                height: 72,
              ),
            );
          } else {
            return TasksBoardView(
              sections: state.sections,
            );
          }
        },
      ),
    );
  }
}
