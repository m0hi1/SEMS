import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.text,
    required this.onPressed,
   
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: const Color.fromARGB(181, 9, 47, 107),
      onPressed: onPressed,
      padding: const EdgeInsets.all(12),
      // padding: EdgeInsets.symmetric(vertical: padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center),
          const Icon(Icons.arrow_forward_ios, color: Colors.white),
        ],
      ),
    );
  }
}
