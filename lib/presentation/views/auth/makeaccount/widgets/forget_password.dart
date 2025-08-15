import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const TextLink({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:  Text(
        text,
        style: TextStyle(color: Colors.white, decoration: TextDecoration.underline),
      ),
    );
  }
}