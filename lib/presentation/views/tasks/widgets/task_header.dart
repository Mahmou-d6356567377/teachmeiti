import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teachmeiti/presentation/blocs/task_bloc/task_bloc.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Task',
              style: GoogleFonts.crimsonPro(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.white, size: 40),
              onPressed: () async {
                final parentContext = context; // capture screen context

                final shouldDelete = await showDialog<bool>(
                  context: parentContext,
                  builder:
                      (ctx) => AlertDialog(
                        title: const Text("Delete All Tasks"),
                        content: const Text(
                          "Are you sure you want to delete all tasks? This cannot be undone.",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(false),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              // use parentContext, not ctx
                              parentContext.read<TaskCubit>().deleteAll();
                              Navigator.of(ctx).pop(true);
                            },
                            child: const Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                );

                if (shouldDelete == true) {
                  ScaffoldMessenger.of(parentContext).showSnackBar(
                    const SnackBar(content: Text("All tasks deleted")),

                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
