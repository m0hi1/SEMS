import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/assets.dart';
import '../../router.dart';
import '../../profile/cubit/profile_cubit.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final sems = context.watch<FirestoreDataCubit>().getUserData();

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(237, 249, 249, 246),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.blue,
              spreadRadius: 20,
              blurRadius: 30,
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(Assets.adminURL),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(sems?.academyName ?? '',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Text(sems?.email ?? '',
                    style: const TextStyle(color: Colors.black87)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
