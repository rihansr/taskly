import 'package:json_annotation/json_annotation.dart';
import 'package:shared/presentation/widgets/widgets.dart' show Equatable;
part 'section_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SectionModel extends Equatable {
  final String? id;
  @JsonKey(name: "project_id")
  final String? projectId;
  final int? order;
  final String? name;

  const SectionModel({
    this.id,
    this.projectId,
    this.order,
    this.name,
  });

  SectionModel copyWith({
    String? id,
    String? projectId,
    int? order,
    String? name,
  }) {
    return SectionModel(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      order: order ?? this.order,
      name: name ?? this.name,
    );
  }

  factory SectionModel.fromJson(Map<String, dynamic> json) =>
      _$SectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SectionModelToJson(this);

  static List<SectionModel> fromJsonList(List<dynamic> json) {
    return json.map((e) => SectionModel.fromJson(e)).toList();
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        id,
        projectId,
      ];
}
