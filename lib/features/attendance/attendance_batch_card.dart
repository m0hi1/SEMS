import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sems/features/batches/batch_model.dart';
import 'package:sems/router.dart';

class AttendanceBatchCard extends StatelessWidget {
  final BatchModel batch;
  final int present;
  final int absent;
  final int leave;

  const AttendanceBatchCard({
    super.key,
    required this.batch,
    required this.present,
    required this.absent,
    required this.leave,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showOptionDialog(context),
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 5)
          ],
        ),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                batch.batchName,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue),
              ),
              Text(
                batch.batchTime,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color.fromARGB(255, 2, 32, 137)),
              ),
            ]),
            const SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Column(
                children: [
                  const Text(
                    'Present',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green),
                  ),
                  Text(
                    present.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text('Absent',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.red)),
                  Text(absent.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.red)),
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Leave',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.red),
                  ),
                  Text(
                    leave.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.red),
                  ),
                ],
              ),
            ])
          ],
        ),
      ),
    );
  }

  void showOptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select an Option'),
          backgroundColor: Colors.white,
          shape: Border.all(style: BorderStyle.none),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    context.push(AppRoute.takeAttendance.path, extra: batch);
                    context.pop();
                  },
                  child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Take Attendance',
                        style: TextStyle(fontSize: 15),
                      )),
                ),
                InkWell(
                  onTap: () {
                    print("hello");
                  },
                  child: const SizedBox(
                      width: double.infinity,
                      child: const Text(
                        'Send Attendance',
                        style: TextStyle(fontSize: 15),
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
