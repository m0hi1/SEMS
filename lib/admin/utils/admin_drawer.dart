import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../router.dart';

Drawer adminDrawer(BuildContext context) {
  return Drawer(
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blueAccent, Colors.blue.shade900],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  bottom: BorderSide(color: Colors.white.withOpacity(0.2)),
                ),
              ),
              accountName: Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: const Text(
                'ACADEMY ID: ace-22-23',
                style: TextStyle(fontSize: 14),
              ),
              currentAccountPicture: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const CircleAvatar(
                  backgroundImage: AssetImage('assets/logo/sems.png'),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // _buildDrawerItem(
                  //   icon: Icons.dashboard,
                  //   title: 'Dashboard',
                  //   onTap: () => context.go('/admin-dashboard'),
                  // ),
                  _buildDrawerItem(
                    icon: Icons.people,
                    title: 'Manage Students',
                    onTap: () => context.push(AppRoute.activeStudentsList.name),
                  ),
                  // _buildDrawerItem(
                  //   icon: Icons.school,
                  //   title: 'Manage Classes',
                  //   onTap: () => context.go('/class-management'),
                  // ),
                  // _buildDrawerItem(
                  //   icon: Icons.book,
                  //   title: 'Manage Courses',
                  //   onTap: () => context.go('/course-management'),
                  // ),
                  // _buildDrawerItem(
                  //   icon: Icons.assignment,
                  //   title: 'Tests & Assignments',
                  //   onTap: () => context.go('/test-management'),
                  // ),
                  // _buildDrawerItem(
                  //   icon: Icons.analytics,
                  //   title: 'Reports & Analytics',
                  //   onTap: () => context.go('/analytics'),
                  // ),
                  const Divider(color: Colors.white30),
                  _buildDrawerItem(
                    icon: Icons.subscriptions,
                    title: 'Subscription Management',
                    onTap: () => context.push(AppRoute.subscriptionPlans.name),
                  ),
                  _buildDrawerItem(
                    icon: Icons.notifications,
                    title: 'Notifications',
                    onTap: () => context.push(AppRoute.notifications.path),
                  ),
                  _buildDrawerItem(
                    icon: Icons.settings,
                    title: 'Settings',
                    onTap: () => context.push(AppRoute.setting.path),
                  ),
                  const Divider(color: Colors.white30),
                  _buildDrawerItem(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    onTap: () => context.push(AppRoute.help.path),
                  ),
                  _buildDrawerItem(
                    icon: Icons.info_outline,
                    title: 'About',
                    onTap: () => context.push(AppRoute.about.path),
                  ),
                  _buildDrawerItem(
                    icon: Icons.share,
                    title: 'Referral Code',
                    onTap: () => context.push(AppRoute.referral.path),
                  ),
                  _buildDrawerItem(
                    icon: Icons.apps,
                    title: 'Other Apps',
                    onTap: () async {
              const url =
                  'https://play.google.com/store/apps/dev?id=5700313618786177705&hl=en_IN';
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              } else {
                throw 'Could not launch $url';
              }
            },
                  ),
                  _buildDrawerItem(
                    icon: Icons.logout,
                    title: 'Logout',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Logout'),
                          content:
                              const Text('Are you sure you want to logout?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                BlocProvider.of<AuthBloc>(context)
                                    .add(SignOut());
                              },
                              child: const Text('Logout'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'SEMS © SmartGalaxyLabs 2025',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildDrawerItem({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: Icon(icon, color: Colors.white),
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
    onTap: onTap,
    dense: true,
    horizontalTitleGap: 0,
  );
}
