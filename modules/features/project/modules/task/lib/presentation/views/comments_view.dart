import 'package:comment/domain/models/comment_model.dart';
import 'package:comment/domain/usecases/all_comments_usecase.dart';
import 'package:comment/domain/usecases/create_comment_usecase.dart';
import 'package:comment/domain/usecases/delete_comment_usecase.dart';
import 'package:comment/domain/usecases/single_comment_usecase.dart';
import 'package:comment/domain/usecases/update_comment_usecase.dart';
import 'package:comment/presentation/bloc/comments_bloc.dart';
import 'package:core/styles/strings.dart';
import 'package:core/utils/enums.dart';
import 'package:core/utils/utils.dart' as utils;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared/di/service_locator.dart';
import 'package:shared/presentation/bloc/bloc.dart';
import 'package:shared/presentation/widgets/widgets.dart';
import '../../domain/models/task_model.dart';

class CommentsView extends StatefulWidget {
  final TaskModel task;
  const CommentsView({
    super.key,
    required this.task,
  });

  @override
  State<CommentsView> createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  final _commentsBloc = CommentsBloc(
    sl<AllCommentsUseCase>(),
    sl<CreateCommentUseCase>(),
    sl<SingleCommentUseCase>(),
    sl<UpdateCommentUseCase>(),
    sl<DeleteCommentUseCase>(),
  );
  late TextEditingController _commentController;
  CommentModel? _updateComment;

  @override
  void initState() {
    _commentController = TextEditingController();
    if (widget.task.id != null) {
      _commentsBloc.add(
        CommentsEvent.allComments(taskId: widget.task.id!),
      );
    }
    super.initState();
  }

  _doComment() {
    if (widget.task.id != null) {
      if (_updateComment != null) {
        _commentsBloc.add(
          CommentsEvent.updateComment(
            comment: _updateComment!.copyWith(
              content: _commentController.text,
            ),
          ),
        );
        _updateComment = null;
      } else {
        _commentsBloc.add(
          CommentsEvent.addComment(
            taskId: widget.task.id!,
            content: _commentController.text,
          ),
        );
      }
      setState(() {
        _commentController.clear();
      });
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<CommentsBloc, CommentsState>(
        bloc: _commentsBloc,
        listener: (BuildContext context, CommentsState state) {},
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(0),
            children: [
              const SizedBox(height: 16),
              Text(
                string.of(context).comments,
                style: theme.textTheme.labelLarge,
              ),
              Skeletonizer(
                enabled: [
                  Status.loading,
                  Status.deleting,
                  Status.updating,
                ].contains(state.status),
                child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemCount: state.comments.length,
                  itemBuilder: (context, index) {
                    final comment = state.comments[index];
                    return ListTile(
                      onLongPress: () {
                        setState(() {
                          _commentController.text = comment.content ?? '';
                          _updateComment = comment;
                        });
                      },
                      contentPadding: const EdgeInsets.all(0),
                      leading: CircleAvatar(
                        backgroundColor: theme.disabledColor,
                        child: const Icon(Icons.person),
                      ),
                      title: Text(comment.content ?? ''),
                      subtitle: comment.postedAt != null
                          ? Text(
                              utils.DateFormat.yMd()
                                  .add_jm()
                                  .format(comment.postedAt!),
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
                              setState(() {
                                _commentController.text = comment.content ?? '';
                                _updateComment = comment;
                              });
                              break;
                            case 1:
                              _commentsBloc.add(
                                CommentsEvent.deleteComment(
                                  id: comment.id ?? '0',
                                ),
                              );
                              if (_updateComment == comment) {
                                setState(() {
                                  _updateComment = null;
                                  _commentController.clear();
                                });
                              }
                              break;
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
              if (_updateComment != null)
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  visualDensity: const VisualDensity(vertical: -4),
                  dense: true,
                  title: Text(
                    string.of(context).updatingComment,
                    style: theme.textTheme.labelSmall,
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.close_rounded,
                      size: 16,
                    ),
                    onPressed: () {
                      setState(() {
                        _updateComment = null;
                        _commentController.clear();
                      });
                    },
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      controller: _commentController,
                      hintText: string.of(context).commentsHint,
                      onFieldSubmitted: (_) => _doComment(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _doComment,
                  ),
                ],
              ),
            ],
          );
        });
  }
}
