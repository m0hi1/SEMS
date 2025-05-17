import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OptionsCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String path;
  const OptionsCard({
    super.key,
    required this.title,
    required this.icon,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(path);
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2)
            ]),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          leading: Text(
            title,
            style: const TextStyle(
                color: Color.fromARGB(255, 11, 38, 160),
                fontWeight: FontWeight.bold),
            textScaler: const TextScaler.linear(1.8),
          ),
          trailing: Icon(
            icon,
            color: const Color.fromARGB(255, 11, 38, 160),
            size: 60,
          ),
        ),
      ),
    );
  }
}
