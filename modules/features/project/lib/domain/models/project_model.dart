import 'package:json_annotation/json_annotation.dart';
import 'package:shared/presentation/widgets/widgets.dart' show Equatable;
part 'project_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProjectModel extends Equatable {
  final String? id;
  final String? name;
  @JsonKey(name: "comment_count")
  final int? commentCount;
  final int? order;
  final String? color;
  @JsonKey(name: "is_shared")
  final bool? isShared;
  @JsonKey(name: "is_favorite")
  final bool? isFavorite;
  @JsonKey(name: "parent_id")
  final String? parentId;
  @JsonKey(name: "is_inbox_project")
  final bool? isInboxProject;
  @JsonKey(name: "is_team_inbox")
  final bool? isTeamInbox;
  @JsonKey(name: "view_style")
  final String? viewStyle;
  final String? url;

  const ProjectModel({
    this.id,
    this.name,
    this.commentCount,
    this.order,
    this.color,
    this.isShared,
    this.isFavorite,
    this.parentId,
    this.isInboxProject,
    this.isTeamInbox,
    this.viewStyle,
    this.url,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectModelToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        id,
        name,
        commentCount,
        order,
        color,
        isShared,
        isFavorite,
        parentId,
        isInboxProject,
        isTeamInbox,
        viewStyle,
        url,
      ];
}
