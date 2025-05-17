import 'package:flutter/material.dart';
import '../utils/loading_dialog.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context, // Pass the context here
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const LoadingDialog();
    },
  );
}

void hideLoadingDialog(BuildContext context) {
  Navigator.of(context).pop();
}
