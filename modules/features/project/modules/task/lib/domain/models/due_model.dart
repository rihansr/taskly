import 'package:json_annotation/json_annotation.dart';
import 'package:shared/presentation/widgets/widgets.dart' show Equatable;
part 'due_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DueModel extends Equatable {
  final DateTime? date;
  @JsonKey(name: "is_recurring")
  final bool? isRecurring;
  final DateTime? datetime;
  final String? string;
  final String? timezone;

  const DueModel({
    this.date,
    this.isRecurring,
    this.datetime,
    this.string,
    this.timezone,
  });

  factory DueModel.fromJson(Map<String, dynamic> json) =>
      _$DueModelFromJson(json);

  Map<String, dynamic> toJson() => _$DueModelToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        date,
        isRecurring,
        datetime,
        string,
        timezone,
      ];
}
