import 'package:freezed_annotation/freezed_annotation.dart';
part 'task_tracker_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TaskTrackerModel {
  final String id;
  final DateTime time;

  TaskTrackerModel({
    required this.id,
    required this.time,
  });

  factory TaskTrackerModel.fromJson(Map<String, dynamic> json) =>
      _$TaskTrackerModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskTrackerModelToJson(this);
}
