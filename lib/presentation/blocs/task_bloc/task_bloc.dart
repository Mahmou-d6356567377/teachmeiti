import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:teachmeiti/models/tasks/task_model.dart';
import 'package:teachmeiti/presentation/blocs/task_bloc/tasks_states.dart';

class TaskCubit extends Cubit<TaskState> {
  final Box<TaskModel> taskBox;

    TaskCubit(this.taskBox) : super(TaskInitial()) {
    loadTasks();

    // 👇 Listen for changes in Hive and reload automatically
    taskBox.watch().listen((event) {
      loadTasks();
    });
  }

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

  void updateTask(int index, TaskModel updatedTask) {
    taskBox.putAt(index, updatedTask);
    loadTasks();
  }


  void deleteAll(){
    taskBox.clear();
    loadTasks();
  }
}
