import 'package:go_router/go_router.dart';
import 'package:sems/router.dart';
import 'package:sems/shared/utils/logger.dart';
import 'package:sems/shared/utils/snacbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../cubit/profile_cubit.dart';
import '../model/user_data.dart';
import '../utils/profile_edit_field.dart';

class ProfileUpdateScreen extends StatefulWidget {
  final UserData userData;
  const ProfileUpdateScreen({super.key, required this.userData});

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();


  final TextEditingController academyNameController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    academyNameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    super.dispose();
  }

  dubugPrint() {
    logger.i(widget.userData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Account"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                child: Icon(Icons.camera_alt, size: 50),
              ),
              const SizedBox(height: 16),
              ProfileEditField(
                label: widget.userData.name,
                hintText: "Enter new your name",
                controller: nameController,
              ),
              ProfileEditField(
                label: widget.userData.email,
                hintText: "Enter new your email",
                controller: emailController,
                readOnly: true,
              ),
              ProfileEditField(
                label: widget.userData.academyName,
                hintText: "Academy new academy name",
                controller: academyNameController,
              ),
              ProfileEditField(
                label: widget.userData.phoneNumber ?? 'Not added',
                hintText: "Enter new mobile number",
                controller: phoneNumberController,
              ),
              ProfileEditField(
                label: widget.userData.address ?? 'Not added',
                hintText: "Enter new address",
                controller: addressController,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                
                  ),
                  onPressed: () {
                    debugPrint("Updating..");
                    context.read<FirestoreDataCubit>().updateUserData(UserData(
                      name: nameController.text,
                      email: emailController.text,
                      academyName: academyNameController.text,
                          academyId: widget.userData.academyId,
                      phoneNumber: phoneNumberController.text,
                      address: addressController.text,

                    ), context);
                  },
                  child: const Text("UPDATE"),
                ),
              ),
              const SizedBox(height: 80),
              
            ],
            
          ),
          
        ),
        
      ),
      
    );
  }

  // Future<void> _updateProfile() async {
  //
  // }
}
