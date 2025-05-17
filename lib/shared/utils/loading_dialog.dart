import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      backgroundColor: Colors.white,
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(width: 16.0),
            Expanded(
              child: Text(
                'Loading...',
                style: TextStyle(fontSize: 16.0), // Adjust text size if needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
