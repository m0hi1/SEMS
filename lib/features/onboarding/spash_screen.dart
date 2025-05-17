import 'package:sems/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _selectRole();
  }

  Future<void> _selectRole() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      context.replace(AppRoute.roleSelection.path);
      debugPrint('Role Selection Screen Navigated..');
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('💦App Loaded.');

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo/logo_sems-trans.png',
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 20),
                Text('SEMS',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: const Color.fromARGB(255, 31, 147, 200),
                        fontWeight: FontWeight.bold,
                        fontSize: 50)),
                const SizedBox(height: 5),
                Text(
                  'Smart Education Management System',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: const Color.fromARGB(255, 31, 80, 164),
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(),
                const SizedBox(height: 5),
                const Text('Loading...'),
              ],
            ),
          ),
          Positioned(
            left: 120,
            bottom: 30,
            child: Text(
                'Powered By SmartGalaxy Labs',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: const Color.fromARGB(255, 49, 86, 150),
                      fontWeight: FontWeight.bold,
                    )),
          ),
        ],
      ),
    );
  }
}
