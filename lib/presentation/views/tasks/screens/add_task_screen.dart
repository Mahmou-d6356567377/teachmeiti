import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:teachmeiti/models/tasks/task_model.dart';
import 'package:teachmeiti/presentation/blocs/task_bloc/task_bloc.dart';
import 'package:teachmeiti/utils/routes/routes.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key, required this.uid});
  final String uid; // You may use this if you want user-specific tasks

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();

  Color? _selectedColor;
  TimeOfDay? _selectedTime;

  void _pickColor() async {
    final colors = [Colors.red, Colors.orange, Colors.green, Colors.blue];
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Select Priority Color"),
        content: Wrap(
          spacing: 8,
          children: colors.map((color) {
            return GestureDetector(
              onTap: () {
                setState(() => _selectedColor = color);
                Navigator.pop(ctx);
              },
              child: CircleAvatar(backgroundColor: color, radius: 24),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _pickTime() async {
    final now = TimeOfDay.now();
    final picked = await showTimePicker(context: context, initialTime: now);
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  void _saveDetails() {
    if (_formKey.currentState!.validate() &&
        _selectedColor != null &&
        _selectedTime != null) {
      final description = _descriptionController.text.trim();
      final colorValue = _selectedColor!.value;
      final timeString = "${_selectedTime!.hour}:${_selectedTime!.minute}";

      final newTask = TaskModel(
        description: description,
        colorValue: colorValue,
        time: timeString,
      );

      // Save via Bloc
      context.read<TaskCubit>().addTask(newTask);

      // Navigate back
      GoRouter.of(context).go(GoRoutes.navbarscreen);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter description" : null,
              ),
              const SizedBox(height: 20),

              // Color Picker
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _pickColor,
                    child: const Text("Pick Priority Color"),
                  ),
                  const SizedBox(width: 12),
                  if (_selectedColor != null)
                    CircleAvatar(backgroundColor: _selectedColor, radius: 14),
                ],
              ),

              const SizedBox(height: 20),

              // Time Picker
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _pickTime,
                    child: const Text("Pick Time"),
                  ),
                  const SizedBox(width: 12),
                  if (_selectedTime != null)
                    Text(
                      _selectedTime!.format(context),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),

              const Spacer(),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveDetails,
                  child: const Text("Save Task"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
