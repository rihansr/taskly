import 'package:comment/domain/models/comment_model.dart';
import 'package:core/styles/strings.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentTile extends StatelessWidget {
  final CommentModel comment;
  final Function() onEdit;
  final Function() onDelete;
  const CommentTile({
    super.key,
    required this.comment,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      onLongPress: onEdit,
      contentPadding: const EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundColor: theme.disabledColor,
        child: const Icon(Icons.person),
      ),
      title: Text(comment.content ?? ''),
      subtitle: comment.postedAt != null
          ? Text(
              DateFormat.yMd().add_jm().format(comment.postedAt!),
            )
          : null,
      dense: true,
      trailing: PopupMenuButton(
        itemBuilder: (context) {
          return [
            string.of(context).edit,
            string.of(context).remove,
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
              onEdit.call();
              break;
            case 1:
              onDelete.call();
              break;
          }
        },
      ),
    );
  }
}
