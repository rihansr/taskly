import 'package:core/styles/strings.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:task/domain/models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final Function(bool status)? onComplete;
  final Function()? onDelete;
  const TaskCard({
    super.key,
    required this.task,
    this.onComplete,
    this.onDelete,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Card(
          elevation: 8,
          margin: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 12,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  task.content ?? '',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      if (task.commentCount != null) ...[
                        WidgetSpan(
                          child: Icon(
                            Icons.comment_outlined,
                            size: 18,
                            color: theme.hintColor,
                          ),
                          alignment: PlaceholderAlignment.middle,
                        ),
                        TextSpan(text: ' ${task.commentCount}'),
                      ],
                      if (task.isCompleted ?? false) ...[
                        const TextSpan(text: ' '),
                        WidgetSpan(
                          child: Icon(
                            Icons.done_all,
                            size: 18,
                            color: theme.hintColor,
                          ),
                          alignment: PlaceholderAlignment.middle,
                        ),
                      ]
                    ],
                    style: theme.textTheme.labelLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 8,
          child: PopupMenuButton(
            itemBuilder: (context) {
              return [
                task.isCompleted ?? false
                    ? string.of(context).reopen
                    : string.of(context).complete,
                string.of(context).remove,
              ].mapIndexed((i, e) {
                return PopupMenuItem(
                  value: i,
                  child: Text(e),
                );
              }).toList();
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(6),
                color: theme.disabledColor,
              ),
              child: Icon(
                Icons.edit,
                size: 12,
                color: theme.hintColor,
              ),
            ),
            onSelected: (i) {
              switch (i) {
                case 0:
                  onComplete?.call(!(task.isCompleted ?? false));
                  break;
                case 1:
                  onDelete?.call();
                  break;
              }
            },
          ),
        ),
      ],
    );
  }
}
