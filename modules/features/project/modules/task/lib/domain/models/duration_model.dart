import 'package:json_annotation/json_annotation.dart';
import 'package:shared/presentation/widgets/widgets.dart' show Equatable;
part 'duration_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DurationModel extends Equatable {
  final int? amount;
  final String? unit;

  const DurationModel({
    this.amount,
    this.unit,
  });

  factory DurationModel.fromJson(Map<String, dynamic> json) =>
      _$DurationModelFromJson(json);

  Map<String, dynamic> toJson() => _$DurationModelToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        amount,
        unit,
      ];
}
