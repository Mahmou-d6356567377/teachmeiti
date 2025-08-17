import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:teachmeiti/models/tasks/task_model.dart';
import 'package:teachmeiti/presentation/blocs/task_bloc/tasks_states.dart';

class TaskCubit extends Cubit<TaskState> {
  final Box<TaskModel> taskBox;

  TaskCubit(this.taskBox) : super(TaskInitial());

  void loadTasks() {
    final tasks =
        taskBox.values
            .whereType<TaskModel>() // only keep TaskModel entries
            .toList();
    emit(TaskLoaded(tasks));
  }

  void addTask(TaskModel task) {
    taskBox.add(task); // ✅ this saves as TaskModel
    loadTasks();
  }

  void deleteTask(int index) {
    taskBox.deleteAt(index);
    loadTasks();
  }
}
