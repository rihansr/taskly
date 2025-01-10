import 'package:core/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared/presentation/widgets/widgets.dart' show Equatable;
part 'due_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DueModel extends Equatable {
  final DateTime? date;
  final String? string;
  final String? lang;

  const DueModel({
    this.date,
    this.lang,
    this.string,
  });

  factory DueModel.fromDate(DateTime datetime) => DueModel(
        date: datetime,
        string: DateFormat.yMMMMEEEEd().format(datetime),
        lang: 'en',
      );

  factory DueModel.fromJson(Map<String, dynamic> json) =>
      _$DueModelFromJson(json);

  Map<String, dynamic> toJson() => _$DueModelToJson(this);

  Map<String, dynamic> toMap() => {
        'due_datetime': date?.toUtc().toIso8601String(),
        'due_lang': lang,
        'due_string': string,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        date,
      ];
}
