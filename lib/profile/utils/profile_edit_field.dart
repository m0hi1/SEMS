import 'package:flutter/material.dart';

class ProfileEditField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool readOnly;

  const ProfileEditField({
    super.key,
    required this.label,
    required this.hintText,
    this.readOnly = false,
    required TextEditingController controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
