import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teachmeiti/presentation/views/home/widgets/chart_card.dart';
import 'package:teachmeiti/presentation/views/home/widgets/subject_list.dart';
import 'package:teachmeiti/utils/consts/const_text.dart';
import 'package:teachmeiti/utils/routes/routes.dart';
import 'package:teachmeiti/widgets/custom_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.uid});
  final String uid;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  String? userUID;

  @override
  void initState() {
    super.initState();
    _loadUserUID();
  }

  Future<void> _loadUserUID() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userUID = prefs.getString(ConstText.sharedprefIDU);
    });
    print(
      '................User UID: $userUID...................................  HERE IT IS ',
    );
  }

  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box(ConstText.hivebox1);
    final userData = userBox.get(
      widget.uid,
      defaultValue: {
        'name': 'Unknown',
        'studentId': '',
        'maritalStatus': '',
        'nationality': '',
        'residence': '',
        'email': 'Unknown',
      },
    );
    final hight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Positioned(
            //   bottom: 0,
            //   child: SvgPicture.asset(ConstImgs.banner1, fit: BoxFit.cover, width: MediaQuery.of(context).size.width ),
            // ),
            CustomBackground(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: hight * 0.2),
                      Text(
                        userData['name'] ?? 'Unknown',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Lets become active!',
                        style: GoogleFonts.corben(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 16),

                      chartcard(totaltasks: 30, completedtasks: 20),
                      const SizedBox(height: 16),

                      // Activities Chart Placeholder
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context).push(GoRoutes.addsubjectscreen);
                        },
                        child: Visibility(
                          visible: userUID == ConstText.admin,
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: SizedBox(
                              height: 120,
                              child: Center(child: Text('+')),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Navigation Butt,on Bar
                      SubjectListWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
