import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0) // unique id for this model
class TaskModel {
  @HiveField(0)
  final String description;

  @HiveField(1)
  final int colorValue;

  @HiveField(2)
  final String time;

  TaskModel({
    required this.description,
    required this.colorValue,
    required this.time,
  });
}
