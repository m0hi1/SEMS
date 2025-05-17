import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sems/auth/bloc/student_auth_bloc.dart';
import 'package:sems/auth/views/role_selection_signin.dart';
import '../../router.dart';
import '../../shared/utils/snacbar_helper.dart';
import '../bloc/auth_bloc.dart';
import '../utils/terms_privacy.dart';

class LoginStudentScreen extends StatelessWidget {
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _academyIdController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  LoginStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return Scaffold(
      body: BlocListener<StudentAuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            if (state.user.role == UserRole.student) {
              context.go(AppRoute.studentHome.path);
            }
          } else if (state is AuthError) {
            SnackbarHelper.showErrorSnackBar(context, 'Unable to Login');
          }
        },
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/bg.png',
                fit: BoxFit.cover,
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Container(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth:
                        isSmallScreen ? size.width * 0.8 : size.width * 0.4,
                  ),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Logo
                        Image.asset(
                          "assets/logo/logo_sems-trans.png",
                          height: isSmallScreen ? 60 : 80,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Student Login',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Academy ID Field
                        CustomTextField(
                          controller: _academyIdController,
                          label: 'Academy ID',
                          icon: Icons.account_balance,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your academy ID';
                            }
                            return null;
                          },
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.qr_code_scanner),
                            onPressed: () {
                              context.push(AppRoute.scanner.path);
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Student ID Field
                        CustomTextField(
                          controller: _studentIdController,
                          label: 'Student ID',
                          icon: Icons.person,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your student ID';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        // Date of Birth Field
                        CustomTextField(
                          controller: _dobController,
                          label: 'Date of Birth',
                          icon: Icons.calendar_today,
                          isDateField: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your date of birth';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              
                            
                              if (_formKey.currentState!.validate()) {
                                context.read<StudentAuthBloc>().add(
                                      StudentLogin(
                                        _academyIdController.text,
                                        _studentIdController.text,
                                        _dobController.text,
                                      ),
                                    );
                                // context.go(AppRoute.studentHome.path);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Terms and Conditions
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                  vertical: size.height * 0.02,
                ),
                child: const TermsAndPrivacyWidget(
                  privacyPolicyUrl: 'link here',
                  termsOfServiceUrl: 'link here',
                  textColor: Colors.white,
                  linkColor: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final Widget? suffixIcon;
  final bool isDateField;
  final String? Function(String?)? validator;

  const CustomTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.suffixIcon,
    this.isDateField = false,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: isDateField,
      validator: validator,
      onTap: isDateField
          ? () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null) {
                controller.text = "${pickedDate.toLocal()}".split(' ')[0];
              }
            }
          : null,
      decoration: InputDecoration(
        labelText: label,
        fillColor: Colors.white,
        prefixIcon: Icon(
          icon,
          color: Colors.blue,
        ),
        suffixIcon: suffixIcon,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
