import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:teachmeiti/presentation/views/profile/widgets/info_container.dart';
import 'package:teachmeiti/presentation/views/profile/widgets/profile_image.dart';
import 'package:teachmeiti/presentation/views/profile/widgets/progress_container.dart';
import 'package:teachmeiti/utils/consts/const_colors.dart';
import 'package:teachmeiti/widgets/custom_background.dart';
import 'package:teachmeiti/utils/consts/const_text.dart';

class ProfileScreen extends StatelessWidget {
  final String uid; // Pass the UID from login or registration

  const ProfileScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box(ConstText.hivebox);
    final userData = userBox.get(uid, defaultValue: {
      'name': 'Unknown',
      'studentId': '',
      'maritalStatus': '',
      'nationality': '',
      'residence': '',
      'email': 'Unknown',
    });

    return Scaffold(
      body: Container(
        color: ConstColors.safeareacolor,
        child: SafeArea(
          child: Stack(
            children: [
              CustomBackground(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ProfileImage(),
                      const SizedBox(height: 20),
                      Text(
                        userData['name'] ?? 'Unknown',
                        style: GoogleFonts.cambay(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        userData['email'] ?? 'Unknown',
                        style: GoogleFonts.cambay(
                          fontSize: 20,
                          color: Colors.grey[400],
                        ),
                      ),
                      const SizedBox(height: 20),
                      InfoContainer(
                        studentId: userData['studentId'],
                        maritalStatus: userData['maritalStatus'],
                        nationality: userData['nationality'],
                        residence: userData['residence'],
                      ),
                      ProgressContainer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
