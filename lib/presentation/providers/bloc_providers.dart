import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:teachmeiti/models/tasks/task_model.dart';
import 'package:teachmeiti/presentation/blocs/task_bloc/task_bloc.dart';
import 'package:teachmeiti/utils/consts/const_text.dart';

class AppBlocProviders {
  static get allBlocProviders => [
        BlocProvider<TaskCubit>(
  create: (context) => TaskCubit(Hive.box<TaskModel>(ConstText.hivebox2))..loadTasks(),
),
      ];
}
