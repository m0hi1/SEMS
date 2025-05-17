import 'package:sems/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/assets.dart';

enum UserRole { admin, student }

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Role'),
        leading: const Icon(Icons.arrow_back),
        backgroundColor: const Color.fromARGB(255, 36, 173, 242),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 5,
        shadowColor: Theme.of(context).shadowColor,
      ),
      body: Container(
        color: const Color.fromARGB(255, 36, 173, 242),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildRoleButton(
                  context: context,
                  role: 'Admin',
                  imageUrl: Assets.adminURL,
                  onPressed: () => _onRoleSelected(context, 'Admin'),
                ),
                const SizedBox(height: 30),
                _buildRoleButton(
                  context: context,
                  role: 'Student',
                  imageUrl: Assets.studentURL,
                  onPressed: () => _onRoleSelected(context, 'Student'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleButton({
    required BuildContext context,
    required String role,
    required String imageUrl,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 170,
      width: 180,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Theme.of(context).cardColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              imageUrl,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
            ),
            const SizedBox(height: 10),
            Text(
              role,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void _onRoleSelected(BuildContext context, String role) {
    switch (role) {
      case 'Admin':
        //context.push(AppRoute.profile.path);
        context.push(AppRoute.login.path);
        debugPrint('Admin selected');
        break;
      case 'Student':
        //context.push(AppRoute.academy_screen.path);
        context.push(AppRoute.studentLogin.path);
        debugPrint('Student selected');
        break;
    }
  }
}
