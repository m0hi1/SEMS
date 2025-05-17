import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  final IconData icon;
  final String value;

  const ProfileField({
    super.key,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 10),
          Flexible(child: Text(value)),
        ],
      ),
    );
  }
}
