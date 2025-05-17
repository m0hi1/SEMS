import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sems/profile/cubit/profile_cubit.dart';
import 'package:sems/profile/utils/profile_field.dart';
import 'package:sems/profile/views/profile_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAcademyScreen extends StatelessWidget {
  const MyAcademyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<FirestoreDataCubit>().getUserData();
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Academy'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Stack(
        children: [
          // Background Container
          Container(
            height: screenHeight / 3,
            width: double.infinity,
            color: Colors.grey[300],
            child: Image.asset(
              'assets/images/penstand.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Positioned Card (Second Layer)
          Align(
            alignment: Alignment.center,
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 56), // Space for CircleAvatar
                    // Details
                    _buildDetailRow(const ProfileField(
                        icon: Icons.computer, value: "ace-22-23")),
                    _buildDetailRow(ProfileField(
                      icon: Icons.business,
                      value: userData?.academyName ?? "ACE Academy",
                    )),
                    _buildDetailRow(
                      ProfileField(
                        icon: Icons.person,
                        value: userData?.name ?? "mohit",
                      ),
                    ),
                    _buildDetailRow(
                      ProfileField(
                        icon: Icons.email,
                        value: userData?.email ?? "mohit@sems.in",
                      ),
                    ),
                    _buildDetailRow(
                      ProfileField(
                        icon: Icons.phone,
                        value: userData?.phoneNumber ?? "+91",
                      ),
                    ),
                    _buildDetailRow(
                      ProfileField(
                        icon: Icons.location_on,
                        value: userData?.address ?? "Ambala",
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Call button
                    ElevatedButton(
                      onPressed: () {
                        _makePhoneCall(userData?.phoneNumber);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: const Text(
                        'CALL',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Positioned CircleAvatar (Third Layer)
          Positioned(
            top: screenHeight / 5.5,
            left: MediaQuery.of(context).size.width / 2 - 40,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Image.asset(
                'assets/logo/sems.png',
                height: 200,
                width: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(ProfileField field) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(field.icon, color: Colors.blue),
          const SizedBox(width: 8),
          Text(
            field.value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Method to make a phone call
  Future<void> _makePhoneCall(String? phoneNumber) async {
    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        throw 'Could not launch $phoneUri';
      }
    } else {
      debugPrint("Phone number is not available.");
    }
  }
}
