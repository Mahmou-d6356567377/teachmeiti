import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:teachmeiti/presentation/blocs/task_bloc/task_bloc.dart';
import 'package:teachmeiti/presentation/blocs/task_bloc/tasks_states.dart';
import 'package:teachmeiti/presentation/views/tasks/widgets/task_header.dart';
import 'package:teachmeiti/presentation/views/tasks/widgets/task_item.dart';
import 'package:teachmeiti/utils/consts/const_colors.dart';
import 'package:teachmeiti/utils/routes/routes.dart';
import 'package:teachmeiti/widgets/custom_background.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).push(GoRoutes.addtaskscreen, extra: uid);
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        color: ConstColors.safeareacolor,
        child: SafeArea(
          child: Stack(
            children: [
              CustomBackground(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 15.0,
                ),
                child: Column(
                  children: [
                    TaskHeader(),

                    /// 👇 Now BlocBuilder auto-updates when Hive changes
                    Expanded(
                      child: BlocBuilder<TaskCubit, TaskState>(
                        builder: (context, state) {
                          if (state is TaskLoaded) {
                            if (state.tasks.isEmpty) {
                              return const Center(
                                child: Text("No tasks yet"),
                              );
                            }

                            return ListView.builder(
                              itemCount: state.tasks.length,
                              itemBuilder: (context, index) {
                                final task = state.tasks[index];
                                return TaskItem(
                                  index: index,
                                  title: "Task ${index + 1}",
                                  description: task.description,
                                  color: Color(task.colorValue),
                                );
                              },
                            );
                          }

                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
