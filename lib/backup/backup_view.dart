import 'package:flutter/material.dart';

class BackupView extends StatelessWidget {
  const BackupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Backup'),
      ),
      body: const Center(
        child: Text('Backup'),
      ),
    );
  }
}
