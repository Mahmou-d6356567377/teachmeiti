import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool selected;

  const NavButton({
    super.key,
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? Colors.deepPurple : Colors.white,
        foregroundColor: selected ? Colors.white : Colors.deepPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: selected ? 4 : 0,
      ),
      onPressed: onTap,
      child: Text(label),
    );
  }
}