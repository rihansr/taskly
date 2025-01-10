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

  // copy with method
  CommentModel copyWith({
    String? content,
    String? id,
    DateTime? postedAt,
    dynamic projectId,
    String? taskId,
    AttachmentModel? attachment,
  }) {
    return CommentModel(
      content: content ?? this.content,
      id: id ?? this.id,
      postedAt: postedAt ?? this.postedAt,
      projectId: projectId ?? this.projectId,
      taskId: taskId ?? this.taskId,
      attachment: attachment ?? this.attachment,
    );
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  static List<CommentModel> fromJsonList(List<dynamic> json) {
    return json.map((e) => CommentModel.fromJson(e)).toList();
  }

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
