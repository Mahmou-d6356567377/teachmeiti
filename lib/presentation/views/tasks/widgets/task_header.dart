
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader({
    super.key,
  });

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
            child: IconButton(onPressed: (){}, icon: Icon(Icons.add, color: Colors.white, size: 40)),
          ),
        ],
      ),
    );
  }
}
