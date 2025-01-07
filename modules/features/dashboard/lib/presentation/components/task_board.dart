
import 'package:core/styles/style.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:task/domain/models/task_model.dart';

class TaskBoard extends StatelessWidget {
  final TaskModel task;
  const TaskBoard({
    super.key,
    required this.task,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: style.defaultDecoration(context),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.content ?? '',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(width: 1, color: Colors.black),
                ),
                child: Text(
                  task.due?.date == null
                      ? '- ---, ----'
                      : DateFormat('d MMM yyyy').format(task.due!.date!),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              if(task.isCompleted ?? false) const Icon(
                Icons.done_all,
                color: Colors.black,
                size: 18,
              ),
            ],
          )
        ],
      ),
    );
  }
}