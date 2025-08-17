import 'package:teachmeiti/models/tasks/task_model.dart' show TaskModel;




abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskModel> tasks;
  TaskLoaded(this.tasks);
}
