import 'package:flutter/material.dart';

class CustomCirclePercentage extends StatelessWidget {
  const CustomCirclePercentage({super.key, required this.percentage});
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: 55,
        height: 55,
        child: CircularProgressIndicator(
          value: percentage,
          backgroundColor: Colors.grey[300],
          color: Color(0xff051329),
          semanticsLabel: '$percentage',
          semanticsValue: '${(percentage * 100).toStringAsFixed(0)}%',
          strokeWidth: 9,
          strokeAlign: 3,
        ),
      ),
    );
  }
}