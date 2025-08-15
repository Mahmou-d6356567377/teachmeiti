import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teachmeiti/core/services/auth_services.dart';
import 'package:teachmeiti/utils/consts/const_text.dart';
import 'package:teachmeiti/utils/routes/routes.dart';
import 'package:teachmeiti/widgets/custom_background.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;
  String? displayName;
  String? email;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    final user = authServices.value.currentUser;
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = user?.displayName ?? "User";
      email = user?.email ?? "No Email";
      notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    });
  }

  void toggleNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', value);
    setState(() => notificationsEnabled = value);
  }

  Future<void> updateDisplayName() async {
    TextEditingController controller = TextEditingController(text: displayName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Display Name'),
        content: TextField(controller: controller),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () async {
                await authServices.value.updateProfile(controller.text);
                setState(() => displayName = controller.text);
                Navigator.pop(context);
              },
              child: const Text('Update')),
        ],
      ),
    );
  }

  Future<void> changePassword() async {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Password'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Enter your email',
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () async {
                await authServices.value.forgetPassword(email: controller.text);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Password reset email sent')),
                );
              },
              child: const Text('Send')),
        ],
      ),
    );
  }

  Future<void> deleteAccount() async {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () async {
                await authServices.value.deleteUser(
                  email: emailController.text,
                  password: passwordController.text,
                );
                Navigator.pop(context);
              },
              child: const Text('Delete')),
        ],
      ),
    );
  }

  Future<void> logout() async {
    try {
    await authServices.value.signOut();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logged out successfully')),
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(ConstText.sharedprefIsLogin, false);
    // Navigate to the login screen
    GoRouter.of(context).go(GoRoutes.makeaccount);
    } catch (e) {
      
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Stack(
        children: [
          CustomBackground(),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Profile Card
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(displayName ?? ''),
                    subtitle: Text(email ?? ''),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: updateDisplayName,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
            
                // Notifications
                Card(
                  child: SwitchListTile(
                    title: const Text('Enable Notifications'),
                    value: notificationsEnabled,
                    onChanged: toggleNotifications,
                    secondary: const Icon(Icons.notifications),
                  ),
                ),
                const SizedBox(height: 16),
            
                // Password Reset
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.lock),
                    title: const Text('Reset Password'),
                    onTap: changePassword,
                  ),
                ),
                const SizedBox(height: 16),
            
                // Delete Account
                Card(
                  color: Colors.red.shade50,
                  child: ListTile(
                    leading: const Icon(Icons.delete, color: Colors.red),
                    title: const Text('Delete Account', style: TextStyle(color: Colors.red)),
                    onTap: deleteAccount,
                  ),
                ),
                const SizedBox(height: 16),
            
                // Logout
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: logout,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
