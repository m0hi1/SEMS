import 'package:firebase_auth/firebase_auth.dart';
import 'package:sems/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/utils/snacbar_helper.dart';
import '../bloc/auth_bloc.dart';
import 'role_selection_signin.dart';

class RegisterScreen extends StatefulWidget {
  final String uid;
  final String email;
  final String name;
  // final String phoneNumber;
  // final dynamic photoUrl;

  const RegisterScreen({
    super.key,
    required this.uid,
    required this.email,
    required this.name,
    // required this.phoneNumber,
    // required this.photoUrl,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _acadmeyNameController = TextEditingController();
  final _acadmeyIdController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _emailController.text = widget.email;
    // _phoneNumberController.text = widget.phoneNumber;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _acadmeyNameController.dispose();
    _acadmeyIdController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          _showSuccessDialog();
          debugPrint('Auth Registered✅');
          SnackbarHelper.showSuccessSnackBar(
              context, 'Registration Successful');

          // Navigate to the home screen
          context.go(AppRoute.home.name);
        } else if (state is AuthError) {
          SnackbarHelper.showErrorSnackBar(context, 'Error: ${state.message}');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Sign Up'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  _buildTextField(_nameController, 'Name'),
                  _buildTextField(_emailController, 'Email', readOnly: true),
                  _buildTextField(_acadmeyNameController, 'Academy Name',
                      validator: (value) => value!.isEmpty
                          ? 'Academy name cannot be empty'
                          : null),
                  _buildTextField(
                    _phoneNumberController,
                    'Phone Number',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null; // Field is not required, so no validation if empty
                      }
                      // Validate only if the field is not empty
                      return !RegExp(r'^\+?[0-9]{10,13}$').hasMatch(value)
                          ? 'Please enter a valid phone number'
                          : null;
                    },
                  ),
                  _buildTextField(
                    _addressController,
                    'Address',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.33,
                        child: ElevatedButton(
                            onPressed: context.pop,
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.red),
                              foregroundColor:
                                  WidgetStateProperty.all(Colors.white),
                            ),
                            child: const Text('EXIT')),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.33,
                        child: ElevatedButton(
                          onPressed: () => _submitForm(context),
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.green),
                            foregroundColor:
                                WidgetStateProperty.all(Colors.white),
                          ),
                          child: const Text('SIGN UP'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool isPassword = false,
    bool readOnly = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          fillColor: readOnly ? Colors.grey[200] : null,
          filled: readOnly,
        ),
        readOnly: readOnly,
        obscureText: isPassword,
        validator: validator,
      ),
    );
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final phoneNumber = _phoneNumberController.text.startsWith('+91')
          ? _phoneNumberController.text
          : '+91${_phoneNumberController.text}';
      String academyId = generateAcademyId(_acadmeyNameController.text);
      final userData = {
        'name': _nameController.text,
        'email': _emailController.text,
        'academyName': _acadmeyNameController.text,
        'academyId': academyId,
        'phoneNumber': phoneNumber,
        'address': _addressController.text,
        'role': UserRole.admin.name,
      };

      context.read<AuthBloc>().onRegistrationComplete(widget.uid, userData);
    }
  }

  /// Generating AcademyId
  String generateAcademyId(
    String academyName,
  ) {
    // Format: acadmyName + year
    final year = DateTime.now().year;
    final academyPrefix = academyName.substring(0, 3).toUpperCase();

    return '$academyPrefix$year';
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Successfully Registered'),
          content: const SizedBox(
            height: 100,
            child: Center(
              child: Icon(Icons.check_circle, size: 50, color: Colors.green),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                context.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
