part of 'comments_bloc.dart';

@freezed
class CommentsEvent with _$CommentsEvent {
  const factory CommentsEvent.allComments({
    required String taskId,
  }) = _AllComments;
  const factory CommentsEvent.addComment({
    required String taskId,
    required String content,
  }) = _AddComment;
  const factory CommentsEvent.singleComment({
    required String id,
  }) = _SingleComment;
  const factory CommentsEvent.updateComment({
    required CommentModel comment,
  }) = _UpdateComment;
  const factory CommentsEvent.deleteComment({
    required String id,
  }) = _DeleteComment;
}
