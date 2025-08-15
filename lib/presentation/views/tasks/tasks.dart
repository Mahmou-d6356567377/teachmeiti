import 'package:flutter/material.dart';
import 'package:teachmeiti/presentation/views/tasks/widgets/task_header.dart';
import 'package:teachmeiti/presentation/views/tasks/widgets/task_item.dart';
import 'package:teachmeiti/utils/consts/const_colors.dart';
import 'package:teachmeiti/widgets/custom_background.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Expanded(
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return TaskItem(
                            index: index,
                            title: 'task',
                            description: 'Description of task $index',
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
