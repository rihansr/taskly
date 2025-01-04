//@GeneratedMicroModule;CommentPackageModule;package:comment/comment.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:injectable/injectable.dart' as _i526;

import 'domain/repositories/comment_repository.dart' as _i60;
import 'domain/usecases/all_comments_usecase.dart' as _i471;
import 'domain/usecases/create_comment_usecase.dart' as _i648;
import 'domain/usecases/delete_comment_usecase.dart' as _i223;
import 'domain/usecases/single_comment_usecase.dart' as _i372;
import 'domain/usecases/update_comment_usecase.dart' as _i969;

class CommentPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.lazySingleton<_i372.SingleCommentUseCase>(
        () => _i372.SingleCommentUseCase(gh<_i60.CommentRepository>()));
    gh.lazySingleton<_i471.AllCommentsUseCase>(
        () => _i471.AllCommentsUseCase(gh<_i60.CommentRepository>()));
    gh.lazySingleton<_i223.DeleteCommentUseCase>(
        () => _i223.DeleteCommentUseCase(gh<_i60.CommentRepository>()));
    gh.lazySingleton<_i648.CreateCommentUseCase>(
        () => _i648.CreateCommentUseCase(gh<_i60.CommentRepository>()));
    gh.lazySingleton<_i969.UpdateCommentUseCase>(
        () => _i969.UpdateCommentUseCase(gh<_i60.CommentRepository>()));
  }
}
