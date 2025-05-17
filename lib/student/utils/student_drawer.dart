import 'package:sems/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudentDrawer extends StatelessWidget {
  const StudentDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Mohit'),
            accountEmail: const Text('2321006'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 50, color: Colors.blue),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // ListTile(
                //   leading: const Icon(Icons.person_outline),
                //   title: const Text('My Profile'),
                //   onTap: () => context.push(AppRoute.profile.path),
                // ),
                ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Attendance'),
                  onTap: () => context.push(AppRoute.viewAttendance.path),
                ),
                ListTile(
                  leading: const Icon(Icons.book),
                  title: const Text('Courses'),
                  onTap: () => context.push(AppRoute.accessMaterials.path),
                ),
                ListTile(
                  leading: const Icon(Icons.assignment),
                  title: const Text('Tests'),
                  onTap: () => context.push(AppRoute.takeTests.path),
                ),
                ListTile(
                  leading: const Icon(Icons.grade),
                  title: const Text('Results'),
                  onTap: () => context.push(AppRoute.viewResults.path),
                ),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('Notifications'),
                  onTap: () => context.push(AppRoute.notifications.path),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () => context.push(AppRoute.setting.path),
                ),
                ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: const Text('Help & Support'),
                  onTap: () => context.push(AppRoute.help.path),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                        child: Container(
                          margin: EdgeInsets.all(12.0),
                          color: Colors.white,
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Are you sure you want to logout?',
                                style: TextStyle(fontSize: 18.0),
                              ),
                              const SizedBox(height: 14.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  const SizedBox(width: 8.0),
                                  ElevatedButton(
                                    child: const Text('Logout'),
                                    onPressed: () {
                                      context.go(AppRoute.roleSelection.path);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
