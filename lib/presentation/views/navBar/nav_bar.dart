import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teachmeiti/presentation/views/chats/chats_screen.dart';
import 'package:teachmeiti/presentation/views/home/home.dart';
import 'package:teachmeiti/presentation/views/profile/profile_screen.dart';
import 'package:teachmeiti/presentation/views/settings/setting_screen.dart';
import 'package:teachmeiti/presentation/views/tasks/tasks.dart';
import 'package:teachmeiti/utils/consts/const_text.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _selectedIndex = 0;
  String? uid; // will store the UID from SharedPreferences
  bool _isLoading = true;

  List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _loadUid();
  }

  Future<void> _loadUid() async {
    final prefs = await SharedPreferences.getInstance();
    uid = prefs.getString(ConstText.sharedprefIDU);

    // Now that we have the UID, initialize screens
    _screens = [
      HomeScreen(),
      Tasks(),
      SettingsScreen(),
      if (uid != null) ProfileScreen(uid: uid!) else Container(), // fallback
    ];

    setState(() {
      _isLoading = false;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff001427),
        unselectedItemColor: Colors.white30,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
