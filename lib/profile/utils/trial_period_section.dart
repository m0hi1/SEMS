import 'package:sems/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TrialPeriodSection extends StatelessWidget {
  const TrialPeriodSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          const Text(
            "Trial Period",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            "${DateTime.now().toString().substring(0, 10)} TO ${DateTime.now().add(const Duration(days: 10)).toString().substring(0, 10)}",
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(
                vertical: 14.0,
                horizontal: MediaQuery.of(context).size.width * 0.33,
              ),
            ),
            onPressed: () {
              context.push(AppRoute.subscriptionPlans.path);
            },
            child: const Text("UPGRADE"),
          ),
        ],
      ),
    );
  }
}
