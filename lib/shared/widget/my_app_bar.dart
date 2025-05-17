import 'package:sems/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

AppBar myAppBar(BuildContext context, {required String title}) {
  return AppBar(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    title: Text(title),
    elevation: 0.1,
    shadowColor: Colors.blue,
    centerTitle: true,
    actions: [
      IconButton(
        icon: const Icon(Icons.notifications),
        onPressed: () {
          context.push(AppRoute.notifications.path);
        },
      ),
    ],
  );
}
