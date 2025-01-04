import 'package:json_annotation/json_annotation.dart';
import 'package:shared/presentation/widgets/widgets.dart' show Equatable;
import 'due_model.dart';
import 'duration_model.dart';
part 'task_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TaskModel extends Equatable {
  @JsonKey(name: "creator_id")
  final String? creatorId;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @JsonKey(name: "assignee_id")
  final String? assigneeId;
  @JsonKey(name: "assigner_id")
  final String? assignerId;
  @JsonKey(name: "comment_count")
  final int? commentCount;
  @JsonKey(name: "is_completed")
  final bool? isCompleted;
  final String? content;
  final String? description;
  final DueModel? due;
  final DurationModel? duration;
  final String? id;
  final List<String>? labels;
  final int? order;
  final int? priority;
  @JsonKey(name: "project_id")
  final String? projectId;
  @JsonKey(name: "section_id")
  final String? sectionId;
  @JsonKey(name: "parent_id")
  final String? parentId;
  final String? url;

  const TaskModel({
    this.creatorId,
    this.createdAt,
    this.assigneeId,
    this.assignerId,
    this.commentCount,
    this.isCompleted,
    this.content,
    this.description,
    this.due,
    this.duration,
    this.id,
    this.labels,
    this.order,
    this.priority,
    this.projectId,
    this.sectionId,
    this.parentId,
    this.url,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  static List<TaskModel> fromJsonList(List<dynamic> json) {
    return json.map((e) => TaskModel.fromJson(e)).toList();
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        id,
        projectId,
        sectionId,
        parentId,
      ];
}
