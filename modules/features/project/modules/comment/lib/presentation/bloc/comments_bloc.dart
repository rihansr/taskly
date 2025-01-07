import 'package:core/utils/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/presentation/bloc/bloc.dart';
import '../../domain/models/comment_model.dart';
import '../../domain/usecases/all_comments_usecase.dart';
import '../../domain/usecases/create_comment_usecase.dart';
import '../../domain/usecases/delete_comment_usecase.dart';
import '../../domain/usecases/single_comment_usecase.dart';
import '../../domain/usecases/update_comment_usecase.dart';
part 'comments_event.dart';
part 'comments_state.dart';
part 'comments_bloc.freezed.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  late AllCommentsUseCase _allCommentsUseCase;
  late SingleCommentUseCase _singleCommentUseCase;
  late CreateCommentUseCase _addCommentUseCase;
  late UpdateCommentUseCase _updateCommentUseCase;
  late DeleteCommentUseCase _deleteCommentUseCase;

  CommentsBloc(
    this._allCommentsUseCase,
    this._addCommentUseCase,
    this._singleCommentUseCase,
    this._updateCommentUseCase,
    this._deleteCommentUseCase,
  ) : super(const _CommentsState()) {
    on<CommentsEvent>((events, emit) async {
      await events.map(
        allComments: (event) async => await _allComments(event, emit),
        singleComment: (event) async => await _singleComment(event, emit),
        addComment: (event) async => await _addComment(event, emit),
        updateComment: (event) async => await _updateComment(event, emit),
        deleteComment: (event) async => await _deleteComment(event, emit),
        reset: (event) async => emit(const _CommentsState()),
      );
    });
  }

  CommentsBloc.comments(
    this._allCommentsUseCase,
  ) : super(const _CommentsState()) {
    on<CommentsEvent>((events, emit) async {
      await events.mapOrNull(
        allComments: (event) async => await _allComments(event, emit),
        reset: (event) async => emit(const _CommentsState()),
      );
    });
  }

  CommentsBloc.single(
    this._addCommentUseCase,
    this._singleCommentUseCase,
    this._updateCommentUseCase,
    this._deleteCommentUseCase,
  ) : super(const _CommentsState()) {
    on<CommentsEvent>((events, emit) async {
      await events.mapOrNull(
        singleComment: (event) async => await _singleComment(event, emit),
        addComment: (event) async => await _addComment(event, emit),
        updateComment: (event) async => await _updateComment(event, emit),
        deleteComment: (event) async => await _deleteComment(event, emit),
        reset: (event) async => emit(const _CommentsState()),
      );
    });
  }

  _allComments(_AllComments event, Emitter<CommentsState> emitter) async {
    emitter(state.copyWith(status: Status.loading));
    final result = await _allCommentsUseCase.invoke(
      {
        'task_id': event.taskId,
      },
    );
    result.fold(
      (failure) => emitter(state.copyWith(
        status: Status.failure,
        errorMessage: failure.errorMessage,
      )),
      (comments) => emitter(
        state.copyWith(
          status: Status.success,
          comments: comments,
        ),
      ),
    );
  }

  _singleComment(_SingleComment event, Emitter<CommentsState> emitter) async {
    emitter(state.copyWith(status: Status.loading));
    final result = await _singleCommentUseCase.invoke(event.id);
    result.fold(
      (failure) => emitter(state.copyWith(
        status: Status.failure,
        errorMessage: failure.errorMessage,
      )),
      (comment) => emitter(
        state.copyWith(
          status: Status.success,
          comment: comment,
        ),
      ),
    );
  }

  _addComment(_AddComment event, Emitter<CommentsState> emitter) async {
    emitter(state.copyWith(status: Status.creating));
    final result = await _addCommentUseCase.invoke(
      {
        'task_id': event.taskId,
        'content': event.content,
      },
    );
    result.fold(
      (failure) => emitter(state.copyWith(
        status: Status.failure,
        errorMessage: failure.errorMessage,
      )),
      (comment) => emitter(
        state.copyWith(
          status: Status.success,
          comment: comment,
          comments: state.comments..add(comment),
        ),
      ),
    );
  }

  _updateComment(_UpdateComment event, Emitter<CommentsState> emitter) async {
    emitter(state.copyWith(status: Status.updating));
    final result = await _updateCommentUseCase.invoke(event.comment);
    result.fold(
      (failure) => emitter(state.copyWith(
        status: Status.failure,
        errorMessage: failure.errorMessage,
      )),
      (comment) => emitter(
        state.copyWith(
          status: Status.success,
          comment: comment,
          comments: state.comments
              .map((e) => e.id == comment.id ? comment : e)
              .toList(),
        ),
      ),
    );
  }

  _deleteComment(_DeleteComment event, Emitter<CommentsState> emitter) async {
    emitter(state.copyWith(status: Status.deleting));
    final result = await _deleteCommentUseCase.invoke(event.id);
    result.fold(
      (failure) => emitter(state.copyWith(
        status: Status.failure,
        errorMessage: failure.errorMessage,
      )),
      (isSuccessful) => emitter(
        isSuccessful
            ? state.copyWith(
                status: Status.success,
                comments: state.comments
                    .where((element) => element.id != event.id)
                    .toList(),
              )
            : state.copyWith(status: Status.initial),
      ),
    );
  }
}
