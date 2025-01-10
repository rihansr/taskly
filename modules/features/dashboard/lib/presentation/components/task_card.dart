import 'package:flutter/material.dart';
import 'package:task/domain/models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  const TaskCard({
    super.key,
    required this.task,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
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
    );
  }
}
