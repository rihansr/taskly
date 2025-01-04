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

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        id,
        projectId,
      ];
}
