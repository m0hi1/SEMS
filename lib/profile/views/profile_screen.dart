import 'package:sems/admin/utils/admin_drawer.dart';
import 'package:sems/profile/model/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sems/shared/widget/my_app_bar.dart';
import 'package:sems/shared/widget/refresh_dialog.dart';
import '../../router.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../cubit/profile_cubit.dart';
import '../utils/action_button.dart';
import '../utils/profile_field.dart';
import '../utils/trial_period_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch data once when screen initializes
    Future.microtask(() => context.read<FirestoreDataCubit>().fetchUserData());
  }
  @override
  Widget build(BuildContext context) {
    final userData = context.watch<FirestoreDataCubit>().getUserData();

    if (userData == null) {
      debugPrint("Profile Data not fetched...");
    }
    debugPrint("Profile Data fetched...");

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedOut) {
          debugPrint("User logged out...");
          context.go(AppRoute.roleSelection.path);
        }
      },
      child: Scaffold(
        appBar: myAppBar(context, title: 'My Account'),
        drawer: adminDrawer(context),
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/bg.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton.icon(
                                    icon: const Icon(Icons.edit),
                                    label: const Text("Edit"),
                                    onPressed: () {
                                      final userData = context
                                          .read<FirestoreDataCubit>()
                                          .getUserData();
                                      if (userData == null) {
                                        debugPrint(
                                            "Profile Data not fetched...");
                                      }
                                      debugPrint("Profile Data fetched...");

                                      context.push(AppRoute.profileUpdate.path,
                                          extra: userData);
                                    },
                                  ),
                                ],
                              ),
                              ProfileField(
                                icon: Icons.computer,
                                value: userData?.academyId ?? "Not Available",
                              ),
                              ProfileField(
                                icon: Icons.business,
                                value: userData?.academyName ?? "Not Available",
                              ),
                              ProfileField(
                                icon: Icons.person,
                                value: userData?.name ?? "Not Available",
                              ),
                              ProfileField(
                                icon: Icons.email,
                                value: userData?.email ?? "Not Available",
                              ),
                              ProfileField(
                                icon: Icons.phone,
                                value:
                                    userData?.phoneNumber! ?? "Not Available",
                              ),
                              ProfileField(
                                icon: Icons.location_on,
                                value: userData?.address! ?? "Not Available",
                              ),
                              const SizedBox(height: 20),
                              ActionButton(
                                text: "SHARE VISITING CARD",
                                onPressed: () {
                                  // Implement share visiting card functionality here
                                },
                              ),
                              const SizedBox(height: 5),
                              ActionButton(
                                text: "SHARE ACADEMY QR CODE",
                                onPressed: () {
                                  // Implement share academy QR code functionality here
                                },
                              ),
                              const SizedBox(height: 5),
                              ActionButton(
                                text: "CHANGE ACADEMY ID REQUEST",
                                onPressed: () {
                                  // Implement academy ID change request functionality here
                                },
                              ),
                              const SizedBox(height: 20),
                              const TrialPeriodSection(),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 44,
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: () {
                                    showBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return LogoutBottomSheet();
                                        });
                                   
                                  },
                                  child: const Text("LOGOUT"),
                                ),
                              ),
                             
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                    Positioned(
                      top: 100,
                      bottom: 700,
                      left: 100,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                            width: 3.0,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          radius: 100,
                          backgroundImage: AssetImage(
                              'assets/logo/sems_logo.png'), // Profile picture path
                        ),
                      ),
                    ),
                      
                  ],
                ),
                
              );
            },
          ),
        ),
      ),
    );
  }
}

class LogoutBottomSheet extends StatelessWidget {
  const LogoutBottomSheet();

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(SignOut());
                  context.pop(context);
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
