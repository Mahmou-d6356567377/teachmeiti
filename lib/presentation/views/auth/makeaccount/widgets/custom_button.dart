import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teachmeiti/utils/consts/const_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ConstColors.brown,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(text, style: GoogleFonts.capriola(
          color: Colors.white,
          fontSize: 18,
        )),
      ),
    );
  }
}
