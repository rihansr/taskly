import 'package:core/styles/drawable.dart';
import 'package:core/styles/strings.dart';
import 'package:core/styles/style.dart';
import 'package:core/utils/debug.dart';
import 'package:core/utils/enums.dart';
import 'package:core/utils/utils.dart' as utils;
import 'package:dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boardview_kanban/board_item.dart';
import 'package:flutter_boardview_kanban/board_list.dart';
import 'package:flutter_boardview_kanban/boardview.dart';
import 'package:flutter_boardview_kanban/boardview_controller.dart';
import 'package:section/domain/models/section_model.dart';
import 'package:section/presentation/bloc/sections_bloc.dart';
import 'package:section/presentation/views/add_section_view.dart';
import 'package:shared/presentation/bloc/bloc.dart';
import 'package:shared/presentation/widgets/widgets.dart';
import 'package:task/domain/models/task_model.dart';
import 'package:task/presentation/bloc/tasks_bloc.dart';
import 'package:task/presentation/views/add_task_view.dart';
import 'package:task/presentation/views/task_details_view.dart';
import '../components/task_card.dart';

class TasksBoardView extends StatefulWidget {
  final List<SectionModel> sections;
  const TasksBoardView({
    super.key,
    required this.sections,
  });

  @override
  State<TasksBoardView> createState() => _TasksBoardViewState();
}

class _TasksBoardViewState extends State<TasksBoardView> {
  BoardViewController boardViewController = BoardViewController();
  List<BoardList> _lists = <BoardList>[];

  @override
  Widget build(BuildContext context) {
    final sectionsBloc = context.read<SectionsBloc>();
    final theme = Theme.of(context);

    return BlocConsumer<TasksBloc, TasksState>(
      bloc: context.watch<TasksBloc>(),
      listener: (context, state) {
        if (state.status == Status.success) {
          context.read<DashboardBloc>().add(
                DashboardEvent.addSectionTasks(
                  sections: widget.sections,
                  tasks: state.tasks,
                ),
              );
        }
      },
      builder: (context, state) {
        if (state.tasks.isEmpty && state.status == Status.loading) {
          return Center(
            child: LottieBuilder.asset(
              drawable.loading,
              width: 72,
              height: 72,
            ),
          );
        }
        _lists = context
            .watch<DashboardBloc>()
            .state
            .sectionTasks
            .entries
            .map(
              (e) => BoardList(
                onStartDragList: (int? listIndex) {
                  debug.print('onStartDragList: $listIndex',
                      tag: 'onStartDragList');
                },
                onTapList: (int? listIndex) async {
                  debug.print('onTapList: $listIndex', tag: 'onTapList');
                },
                onDropList: (int? listIndex, int? oldListIndex) {
                  debug.print(
                      'onDropList: $listIndex, oldListIndex: $oldListIndex',
                      tag: 'onDropList');
                },
                headerBackgroundColor: theme.primaryColor,
                backgroundColor: theme.scaffoldBackgroundColor,
                header: [
                  const SizedBox(width: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        e.key.name ?? '',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  if (e.key.id != null)
                    PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          string.of(context).edit,
                          string.of(context).remove,
                        ].mapIndexed((i, e) {
                          return PopupMenuItem(
                            key: ValueKey(i),
                            value: i,
                            child: Text(e),
                          );
                        }).toList();
                      },
                      child: Icon(
                        CupertinoIcons.ellipsis_vertical,
                        size: 18,
                        color: theme.colorScheme.onPrimary,
                      ),
                      onSelected: (i) {
                        switch (i) {
                          case 0:
                            showModalBottomSheet(
                              context: context,
                              enableDrag: true,
                              showDragHandle: true,
                              shape: style.defaultBottomSheetShape,
                              builder: (_) => AddSectionView(section: e.key),
                            ).then(
                              (section) {
                                if (section != null) {
                                  context.read<SectionsBloc>().add(
                                        SectionsEvent.updateSection(
                                          section: section as SectionModel,
                                        ),
                                      );
                                }
                              },
                            );
                            break;
                          case 1:
                            sectionsBloc.add(
                              SectionsEvent.deleteSection(id: e.key.id ?? ''),
                            );
                            break;
                        }
                      },
                    ),
                  const SizedBox(width: 8),
                ],
                items: e.value
                    .map(
                      (task) => BoardItem(
                        onStartDragItem: (int? listIndex, int? itemIndex,
                            BoardItemState state) {
                          debug.print(
                            'onStartDragItem: $listIndex, $itemIndex, $state',
                            tag: 'onStartDragItem',
                          );
                        },
                        onDropItem: (
                          int? listIndex,
                          int? itemIndex,
                          int? oldListIndex,
                          int? oldItemIndex,
                          BoardItemState state,
                        ) {
                          if (listIndex == oldListIndex) return;
                          final newSection = context
                              .read<DashboardBloc>()
                              .state
                              .sectionTasks
                              .keys
                              .elementAt(listIndex!);
                          context.read<TasksBloc>().add(
                                TasksEvent.addTask(
                                  task: task.clone(
                                    id: null,
                                    sectionId: newSection.id,
                                  ),
                                ),
                              );
                          context
                              .read<TasksBloc>()
                              .add(TasksEvent.deleteTask(id: task.id ?? '0'));
                        },
                        onTapItem: (int? listIndex, int? itemIndex,
                            BoardItemState state) async {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (_) => TaskDetailsView(task: task),
                          );
                        },
                        item: TaskCard(
                          key: ValueKey(task.id),
                          task: task,
                          onComplete: (shouldClose) {
                            context.read<TasksBloc>().add(
                                  shouldClose
                                      ? TasksEvent.closeTask(id: task.id ?? '0')
                                      : TasksEvent.reopenTask(
                                          id: task.id ?? '0'),
                                );
                          },
                          onDelete: () {
                            context.read<TasksBloc>().add(
                                  TasksEvent.deleteTask(id: task.id ?? '0'),
                                );
                          },
                        ),
                      ),
                    )
                    .toList(),
                footer: Container(
                  margin: const EdgeInsets.all(12),
                  alignment: Alignment.centerRight,
                  child: FloatingActionButton.small(
                    heroTag: null,
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      enableDrag: true,
                      showDragHandle: true,
                      shape: style.defaultBottomSheetShape,
                      builder: (_) => AddTaskView(
                        projectId: e.key.projectId ?? '0',
                        sectionId: e.key.id,
                      ),
                    ).then(
                      (task) {
                        if (task != null) {
                          context.read<TasksBloc>().add(
                                TasksEvent.addTask(task: task as TaskModel),
                              );
                        }
                      },
                    ),
                    child: state.status == Status.creating
                        ? CupertinoActivityIndicator(
                            color: theme.colorScheme.onPrimary,
                          )
                        : const Icon(Icons.add),
                  ),
                ),
              ),
            )
            .toList();

        return Skeletonizer(
          enabled: [
            Status.loading,
            Status.updating,
            Status.deleting,
          ].contains(state.status),
          child: SafeArea(
            top: false,
            child: BoardView(
              lists: _lists,
              boardViewController: boardViewController,
            ),
          ),
        );
      },
    );
  }
}
