import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:go_router/go_router.dart';
import 'package:teachmeiti/presentation/views/auth/makeaccount/widgets/custom_button.dart';
import 'package:teachmeiti/presentation/views/auth/makeaccount/widgets/logo_header.dart';
import 'package:teachmeiti/utils/routes/routes.dart';
import 'package:teachmeiti/utils/consts/const_text.dart';
import 'package:teachmeiti/widgets/custom_text_field.dart';

class MakeAccountDetailsScreen extends StatefulWidget {
  final String uid; // pass UID from first screen
  const MakeAccountDetailsScreen({super.key, required this.uid});

  @override
  State<MakeAccountDetailsScreen> createState() =>
      _MakeAccountDetailsScreenState();
}

class _MakeAccountDetailsScreenState extends State<MakeAccountDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _maritalStatusController =
      TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _residenceController = TextEditingController();

  bool _isLoading = false;

  Future<void> _saveDetails() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final box = Hive.box(ConstText.hivebox);
      await box.put(widget.uid, {
        'name': _nameController.text.trim(),
        'studentId': _studentIdController.text.trim(),
        'maritalStatus': _maritalStatusController.text.trim(),
        'nationality': _nationalityController.text.trim(),
        'residence': _residenceController.text.trim(),
      });

      setState(() => _isLoading = false);

      // Navigate to main screen
      GoRouter.of(context).go(GoRoutes.navbarscreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background can be same as first screen
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    const LogoHeader(),
                    const SizedBox(height: 40),
                    CustomTextField(
                      controller: _nameController,
                      hintText: 'Full Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _studentIdController,
                      hintText: 'Student ID',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your student ID';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _maritalStatusController,
                      hintText: 'Marital Status',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _nationalityController,
                      hintText: 'Nationality',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _residenceController,
                      hintText: 'Residence',
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: _isLoading ? 'Saving...' : 'Save Details',
                      onPressed: _saveDetails,
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
