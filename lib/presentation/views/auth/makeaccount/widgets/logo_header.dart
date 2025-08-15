import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoHeader extends StatelessWidget {
  const LogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image.asset('assets/aau_logo.png', height: 80), // Replace with your logo
         Text(
          'LMS',
          textAlign: TextAlign.center,
          style: GoogleFonts.capriola(fontSize: 40, fontWeight: FontWeight.bold , color: Color(0xff6750ad)),
        ),

      ],
    );
  }
}
