
import 'package:flutter/material.dart';
import 'package:teachmeiti/presentation/views/profile/widgets/custom_circle_percentage.dart';

class ProgressContainer extends StatelessWidget {
  const ProgressContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.symmetric(vertical: 15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(8),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PROGRESS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Tasks Completed: 20/30'),
                  Text('Progress: 66%'),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
    
                   CustomCirclePercentage(percentage: 2/3),
                   CustomCirclePercentage(percentage: .66),
                ],
              ),
              
            ],
          ),
    );
  }
}