import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class GridButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const GridButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double iconSize = constraints.maxWidth * 0.3;
        final double fontSize = constraints.maxWidth * 0.1;

        return InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: iconSize * 2,
                  width: iconSize * 2,
                  decoration: BoxDecoration(
                    color: color,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 5,
                        spreadRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.circular(iconSize),
                  ),
                  child: Icon(icon, size: iconSize, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
