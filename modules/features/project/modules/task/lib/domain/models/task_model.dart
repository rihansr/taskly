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

  TaskModel copyWith({
    String? creatorId,
    DateTime? createdAt,
    String? assigneeId,
    String? assignerId,
    int? commentCount,
    bool? isCompleted,
    String? content,
    String? description,
    DueModel? due,
    DurationModel? duration,
    String? id,
    List<String>? labels,
    int? order,
    int? priority,
    String? projectId,
    String? sectionId,
    String? parentId,
    String? url,
  }) {
    return TaskModel(
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
      assigneeId: assigneeId ?? this.assigneeId,
      assignerId: assignerId ?? this.assignerId,
      commentCount: commentCount ?? this.commentCount,
      isCompleted: isCompleted ?? this.isCompleted,
      content: content ?? this.content,
      description: description ?? this.description,
      due: due ?? this.due,
      duration: duration ?? this.duration,
      id: id ?? this.id,
      labels: labels ?? this.labels,
      order: order ?? this.order,
      priority: priority ?? this.priority,
      projectId: projectId ?? this.projectId,
      sectionId: sectionId ?? this.sectionId,
      parentId: parentId ?? this.parentId,
      url: url ?? this.url,
    );
  }

  TaskModel clone({
    String? creatorId,
    DateTime? createdAt,
    String? assigneeId,
    String? assignerId,
    int? commentCount,
    bool? isCompleted,
    String? content,
    String? description,
    DueModel? due,
    DurationModel? duration,
    String? id,
    List<String>? labels,
    int? order,
    int? priority,
    String? projectId,
    String? sectionId,
    String? parentId,
    String? url,
  }) {
    return TaskModel(
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
      assigneeId: assigneeId ?? this.assigneeId,
      assignerId: assignerId ?? this.assignerId,
      commentCount: commentCount ?? this.commentCount,
      isCompleted: isCompleted ?? this.isCompleted,
      content: content ?? this.content,
      description: description ?? this.description,
      due: due ?? this.due,
      duration: duration ?? this.duration,
      id: id,
      labels: labels ?? this.labels,
      order: order ?? this.order,
      priority: priority ?? this.priority,
      projectId: projectId ?? this.projectId,
      sectionId: sectionId,
      parentId: parentId ?? this.parentId,
      url: url ?? this.url,
    );
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  Map<String, dynamic> toMap() => {
        "creator_id": creatorId,
        "created_at": createdAt?.toIso8601String(),
        "assignee_id": assigneeId,
        "assigner_id": assignerId,
        "comment_count": commentCount,
        "is_completed": isCompleted,
        "content": content,
        "description": description,
        ...due?.toMap() ?? {},
        ...duration?.toMap() ?? {},
        "id": id,
        "labels": labels,
        "order": order,
        "priority": priority,
        "project_id": projectId,
        "section_id": sectionId,
        "parent_id": parentId,
        "url": url,
      };

  static List<TaskModel> fromJsonList(List<dynamic> json) {
    return json.map((e) => TaskModel.fromJson(e)).toList();
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      commentCount,
      isCompleted,
      content,
      description,
      due,
      duration,
      id,
      projectId,
      sectionId,
    ];
  }
}
