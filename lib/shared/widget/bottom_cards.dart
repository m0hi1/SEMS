import 'package:flutter/material.dart';

class BottomCards extends StatelessWidget {
  final int? activeBatches;
  final int? inactiveBatches;
  const BottomCards({
    super.key,
    this.activeBatches,
    this.inactiveBatches,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // First card for "Batches"
          Expanded(
            child: Card(
              color: Colors.greenAccent,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Batches',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Active:  ${activeBatches ?? 0}',
                        style: const TextStyle(color: Colors.white)),
                    Text('Inactive: ${inactiveBatches ?? 0}',
                        style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          const Expanded(
            child: Card(
              color: Colors.orangeAccent,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Students',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Active', style: TextStyle(color: Colors.white)),
                    Text('Inactive', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Third card for "Staff"
          const Expanded(
            child: Card(
              color: Colors.redAccent,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Staff',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Active', style: TextStyle(color: Colors.white)),
                    Text('Inactive', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
