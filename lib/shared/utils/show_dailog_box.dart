import 'package:flutter/material.dart';

Future<void> dialogBuilder(BuildContext context, Widget dailog) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return dailog;
    },
  );
}
