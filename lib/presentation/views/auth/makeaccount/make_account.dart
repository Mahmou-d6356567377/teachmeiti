import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teachmeiti/core/services/auth_services.dart';
import 'package:teachmeiti/presentation/views/auth/makeaccount/widgets/custom_button.dart';
import 'package:teachmeiti/presentation/views/auth/makeaccount/widgets/custom_password_field.dart';
import 'package:teachmeiti/presentation/views/auth/makeaccount/widgets/forget_password.dart';
import 'package:teachmeiti/presentation/views/auth/makeaccount/widgets/logo_header.dart';
import 'package:teachmeiti/utils/consts/const_imgs.dart';
import 'package:teachmeiti/utils/consts/const_text.dart';
import 'package:teachmeiti/utils/routes/routes.dart';
import 'package:teachmeiti/widgets/custom_text_field.dart';

class MakeAccount extends StatefulWidget {
  const MakeAccount({Key? key}) : super(key: key);

  @override
  State<MakeAccount> createState() => _MakeAccountState();
}

class _MakeAccountState extends State<MakeAccount> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isauthed = false;
  void showCustomSnackBar(
    BuildContext context,
    String message, {
    Color backgroundColor = Colors.red,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: backgroundColor),
    );
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final userCredential = await authServices.value
            .createUserWithEmailAndPassword(
              _emailController.text.trim(),
              _passwordController.text,
            );

        setState(() => _isLoading = false);

        showCustomSnackBar(
          context,
          'Account created: ${userCredential.user?.email}',
          backgroundColor: Colors.green,
        );
        print(
          'User created: ${userCredential.user?.uid} >>>>>>>>>>>>>>>>>>>>>',
        );

        
        final uid = userCredential.user?.uid;
        final email = userCredential.user?.email;
        GoRouter.of(context).push(
          GoRoutes.makeacountdetailscreen,
          extra: uid,
        );
        if (uid != null && email != null) {
          // Save to SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(ConstText.sharedprefIDU, uid);
          await prefs.setString(ConstText.sharedprefEmail, email);
          setState(() {
            _isauthed = true;
          });
          await prefs.setBool(ConstText.sharedprefIsLogin, _isauthed);
        }
      } catch (error) {
        setState(() => _isLoading = false);
        showCustomSnackBar(
          context,
          '..............Registration failed: $error',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(bottom: 0, child: SvgPicture.asset(ConstImgs.banner1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LogoHeader(),
                  const SizedBox(height: 90),
                  Text(
                    'Login',
                    style: GoogleFonts.capriola(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      final emailRegex = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomPasswordField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    text: _isLoading ? 'Creating...' : 'Make account',
                    onPressed: _register,
                  ),
                  const SizedBox(height: 10),

                  TextLink(
                    text: 'Already have an account? Sign In',
                    onTap: () {
                      GoRouter.of(context).push(GoRoutes.signInscreen );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
