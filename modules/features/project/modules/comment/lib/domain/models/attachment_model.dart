import 'package:json_annotation/json_annotation.dart';
import 'package:shared/presentation/widgets/widgets.dart' show Equatable;
part 'attachment_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AttachmentModel extends Equatable {
  @JsonKey(name: "file_name")
  final String? fileName;
  @JsonKey(name: "file_type")
  final String? fileType;
  @JsonKey(name: "file_url")
  final String? fileUrl;
  @JsonKey(name: "resource_type")
  final String? resourceType;

  const AttachmentModel({
    this.fileName,
    this.fileType,
    this.fileUrl,
    this.resourceType,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      _$AttachmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentModelToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        fileName,
        fileType,
        fileUrl,
        resourceType,
      ];
}
