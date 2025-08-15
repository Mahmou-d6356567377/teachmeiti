import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({Key? key}) : super(key: key);

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();
  bool isLoading = false;

  void showSnackMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> addSubject() async {
  if (nameController.text.isEmpty ||
      descriptionController.text.isEmpty ||
      gradeController.text.isEmpty) {
    showSnackMessage("Please fill in all fields");
    return;
  }

  setState(() => isLoading = true);

  try {
    await FirebaseFirestore.instance.collection('subjects').add({
      'name': nameController.text.trim(),
      'description': descriptionController.text.trim(),
      'grade': gradeController.text.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    showSnackMessage("Subject added successfully");

    nameController.clear();
    descriptionController.clear();
    gradeController.clear();
    GoRouter.of(context).pop(); // Navigate back after adding subject
  } catch (e) {
    showSnackMessage("Error: $e");
  } finally {
    setState(() => isLoading = false);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Subject"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Subject Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: gradeController,
              decoration: const InputDecoration(
                labelText: "Grade",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : addSubject,
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Add Subject"),
            ),
          ],
        ),
      ),
    );
  }
}
