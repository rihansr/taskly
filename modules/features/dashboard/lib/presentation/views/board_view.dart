import 'package:core/utils/enums.dart';
import 'package:dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:kanban_board/custom/board.dart';
import 'package:kanban_board/models/inputs.dart';
import 'package:section/domain/models/section_model.dart';
import 'package:shared/presentation/bloc/bloc.dart';
import 'package:task/presentation/bloc/tasks_bloc.dart';

class BoardView extends StatefulWidget {
  final List<SectionModel> sections;
  const BoardView({
    super.key,
    required this.sections,
  });

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  @override
  Widget build(BuildContext context) {
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
          return KanbanBoard(
            context
                .watch<DashboardBloc>()
                .state
                .sectionTasks
                .entries
                .map(
                  (e) => BoardListsData(
                    title: e.key.name ?? '',
                    items: e.value
                        .map(
                          (task) => Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                )),
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              task.content ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
            onItemLongPress: (cardIndex, listIndex) {},
            onItemReorder:
                (oldCardIndex, newCardIndex, oldListIndex, newListIndex) {},
            onListLongPress: (listIndex) {},
            onListReorder: (oldListIndex, newListIndex) {},
            onItemTap: (cardIndex, listIndex) {},
            onListTap: (listIndex) {},
            onListRename: (oldName, newName) {},
            backgroundColor: Colors.white,
            displacementY: 124,
            displacementX: 100,
            textStyle: const TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
