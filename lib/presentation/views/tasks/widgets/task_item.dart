
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key, required this.index, required this.title, required this.description, required this.color,
  });

  final int index;
  final String title;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ListTile(
        title: Text('$title '),
        subtitle: Text(' $description${index + 1}'),
        leading: Icon(Icons.task),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Handle task tap
        },
      ),
    );
  }
}
