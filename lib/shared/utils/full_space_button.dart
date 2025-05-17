import 'package:flutter/material.dart';

class FullSpaceButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? label;
  const FullSpaceButton({super.key, required this.onPressed, this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label ?? 'Submit',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
