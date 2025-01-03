import 'package:json_annotation/json_annotation.dart';
import 'package:shared/presentation/widgets/widgets.dart' show Equatable;
import 'attachment_model.dart';
part 'comment_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CommentModel extends Equatable {
  final String? content;
  final String? id;
  @JsonKey(name: "posted_at")
  final DateTime? postedAt;
  @JsonKey(name: "project_id")
  final dynamic projectId;
  @JsonKey(name: "task_id")
  final String? taskId;
  final AttachmentModel? attachment;

  const CommentModel({
    this.content,
    this.id,
    this.postedAt,
    this.projectId,
    this.taskId,
    this.attachment,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        content,
        id,
        postedAt,
        projectId,
        taskId,
        attachment,
      ];
}
