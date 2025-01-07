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
import 'package:task/presentation/bloc/tasks_bloc.dart';
import '../components/task_board.dart';

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
      bloc: context.read<TasksBloc>(),
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
        if (state.status == Status.loading) {
          return const Center(
            child: Text('Tasks Loading...'),
          );
        } else if (state.status == Status.success) {
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
                  backgroundColor: theme.cardColor,
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
                    PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          string.of(context).edit,
                          string.of(context).delete,
                        ].mapIndexed((i, e) {
                          return PopupMenuItem(
                            value: i,
                            child: Text(e),
                          );
                        }).toList();
                      },
                      child: const Icon(
                        CupertinoIcons.ellipsis_vertical,
                        size: 18,
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
                            debug.print(
                                'onDropItem: $listIndex, $itemIndex, oldListIndex: $oldListIndex, oldItemIndex: $oldItemIndex, $state',
                                tag: 'onDropItem');
                          },
                          onTapItem: (int? listIndex, int? itemIndex,
                              BoardItemState state) async {
                            debug.print(
                                'onTapItem: $listIndex, $itemIndex, $state',
                                tag: 'onTapItem');
                          },
                          item: TaskBoard(
                            key: ValueKey(task.id),
                            task: task,
                          ),
                        ),
                      )
                      .toList(),
                  footer: Container(
                    margin: const EdgeInsets.all(12),
                    alignment: Alignment.centerRight,
                    child: FloatingActionButton.small(
                      // onPressed: () => showModalBottomSheet(
                      //   context: context,
                      //   enableDrag: true,
                      //   showDragHandle: true,
                      //   shape: style.defaultBottomSheetShape,
                      //   builder: (_) => Container(),
                      // ).then(
                      //   (task) {
                      //     if (task != null) {}
                      //   },
                      // ),
                      onPressed: () {
                        context.read<TasksBloc>().add(
                          TasksEvent.addTask(
                            content: "Bug Fix & Testing",
                            description: "Fix the bug and test the app",
                            sectionId: e.key.id ?? '',
                            projectId: e.key.projectId ?? '',
                          ),
                        );
                      },
                      child: state.status == Status.creating
                          ? const CupertinoActivityIndicator()
                          : const Icon(Icons.add),
                    ),
                  ),
                ),
              )
              .toList();

          return BoardView(
            lists: _lists,
            boardViewController: boardViewController,
          );

          // _list = context
          //     .watch<DashboardBloc>()
          //     .state
          //     .sectionTasks
          //     .entries
          //     .map(
          //       (e) => BoardListsData(
          //         //title: e.key.name,
          //         backgroundColor: theme.scaffoldBackgroundColor,
          //         width: dimen.width * 0.6,
          //         //headerBackgroundColor: Colors.red,
          //         header: DecoratedBox(
          //           decoration: BoxDecoration(
          //             gradient: LinearGradient(
          //               colors: [
          //                 theme.primaryColor,
          //                 theme.primaryColor.withOpacity(0.5),
          //               ],
          //             ),
          //           ),
          //           child: Text(e.key.name ?? ''),
          //         ),
          //         items: e.value
          //             .map(
          //               (task) => TaskBoard(
          //                 key: ValueKey(task.id),
          //                 task: task,
          //               ),
          //             )
          //             .toList(),
          //       ),
          //     )
          //     .toList();
          // return KanbanBoard(
          //   _list,
          //   listDecoration: BoxDecoration(
          //     color: theme.scaffoldBackgroundColor,
          //     borderRadius: BorderRadius.circular(16),
          //   ),
          //   onItemLongPress: (cardIndex, listIndex) {
          //     debug.print('cardIndex: $cardIndex, listIndex: $listIndex');
          //   },
          //   onItemReorder:
          //       (oldCardIndex, newCardIndex, oldListIndex, newListIndex) {
          //     debug.print(
          //         'oldCardIndex: $oldCardIndex, newCardIndex: $newCardIndex, oldListIndex: $oldListIndex, newListIndex: $newListIndex',
          //         tag: 'onItemReorder');
          //   },
          //   onListLongPress: (listIndex) {
          //     debug.print('listIndex: $listIndex', tag: 'onListLongPress');
          //   },
          //   onListReorder: (oldListIndex, newListIndex) {
          //     debug.print(
          //         'oldListIndex: $oldListIndex, newListIndex: $newListIndex',
          //         tag: 'onListReorder');
          //   },
          //   onItemTap: (cardIndex, listIndex) {
          //     debug.print('cardIndex: $cardIndex, listIndex: $listIndex',
          //         tag: 'onItemTap');
          //   },
          //   onListTap: (listIndex) {
          //     debug.print('listIndex: $listIndex', tag: 'onListTap');
          //   },
          //   onNewCardInsert: (listIndex, cardIndex, content) {
          //     debug.print(
          //         'listIndex: $listIndex, cardIndex: $cardIndex, content: $content',
          //         tag: 'onNewCardInsert');
          //   },
          //   onListRename: (oldName, newName) {
          //     debug.print('oldName: $oldName, newName: $newName',
          //         tag: 'onListRename');
          //   },
          //   displacementY: 124,
          //   displacementX: 100,
          //   textStyle: theme.textTheme.titleMedium?.copyWith(
          //     fontWeight: FontWeight.w500,
          //   ),
          // );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}