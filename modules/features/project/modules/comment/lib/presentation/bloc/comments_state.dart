part of 'comments_bloc.dart';

enum Status { initial, loading, creating, updating, deleting, success, failure }

@Freezed(copyWith: true, equal: true)
class CommentsState with _$CommentsState {
  const factory CommentsState({
    @Default(Status.initial) Status status,
    String? errorMessage,
    @Default(<CommentModel>[]) List<CommentModel> comments,
    @Default(CommentModel()) CommentModel comment,
  }) = _CommentsState;
}
