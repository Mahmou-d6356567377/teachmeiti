
import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          
          colors: [
            Color(0xffe38f42),
            Color(0xffe38f42),
            Color(0xffe38f42),
            Color(0xffcd6758),
            Color(0xff6f3778),
            Color(0xff471c8f),
            Color(0xff1f267e),
            Color(0xff142d57),
            Color(0xff031430),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}