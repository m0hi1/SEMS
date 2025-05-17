import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSection(
            'Account Settings',
            [
              SettingsTile(
                icon: Icons.person,
                title: 'Profile Information',
                onTap: () {
                  // Navigate to profile settings
                },
              ),
              SettingsTile(
                icon: Icons.notifications,
                title: 'Notification Preferences',
                onTap: () {
                  // Navigate to notification settings
                },
              ),
              SettingsTile(
                icon: Icons.lock,
                title: 'Privacy Settings',
                onTap: () {
                  // Navigate to privacy settings
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSection(
            'App Settings',
            [
              SettingsTile(
                icon: Icons.color_lens,
                title: 'Theme',
                trailing: Switch(
                  value: false,
                  onChanged: (value) {
                    // Toggle theme
                  },
                ),
              ),
              SettingsTile(
                icon: Icons.language,
                title: 'Language',
                subtitle: 'English',
                onTap: () {
                  // Show language picker
                },
              ),
              SettingsTile(
                icon: Icons.notifications_active,
                title: 'Push Notifications',
                trailing: Switch(
                  value: true,
                  onChanged: (value) {
                    // Toggle notifications
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSection(
            'Support',
            [
              SettingsTile(
                icon: Icons.help,
                title: 'Help Center',
                onTap: () {
                  // Navigate to help center
                },
              ),
              SettingsTile(
                icon: Icons.policy,
                title: 'Privacy Policy',
                onTap: () {
                  // Show privacy policy
                },
              ),
              SettingsTile(
                icon: Icons.info,
                title: 'About',
                subtitle: 'Version 1.0.0',
                onTap: () {
                  // Show about dialog
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
        Card(
          elevation: 2,
          child: Column(children: children),
        ),
      ],
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingsTile({
    Key? key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
