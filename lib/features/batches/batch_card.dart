import 'package:sems/router.dart';
import 'package:sems/features/batches/batch_model.dart';
import 'package:sems/features/batches/bloc/batch_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BatchesCard extends StatelessWidget {
  final BatchModel batch;
  const BatchesCard({
    super.key,
    required this.batch,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _dialogBuilder(context, batch);
      },
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2)
          ],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: ListTile(
          contentPadding: const EdgeInsets.all(5),
          leading: const Icon(
            Icons.group_outlined,
            color: Colors.blue,
            size: 50,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                batch.batchName,
                style: const TextStyle(color: Colors.blue),
                textScaler: const TextScaler.linear(1.1),
              ),
              Row(
                children: [
                  Text(
                    batch.batchTime.toString(),
                  ),
                  const Spacer(),
                  Text(
                    batch.isActive,
                  ),
                  const Spacer(),
                ],
              )
            ],
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 20,
          ),
        ),
      ),
    );
  }

  static Future<dynamic> _dialogBuilder(
    BuildContext context,
    BatchModel batch,
  ) {
    const TextStyle batchDailogTextStyle =
        TextStyle(fontWeight: FontWeight.normal);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: Border.all(width: 2, color: Colors.transparent),
          title: const Text('Select an option'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  context.pop(context);
                  batchInfo(context);
                },
                child: const Text(
                  'Batch Info',
                  style: batchDailogTextStyle,
                ),
              ),
              TextButton(
                  onPressed: () {
                    context.pop(context);
                    context.push(AppRoute.newBatch.path, extra: batch);
                  },
                  child: const Text(
                    'Edit Batch',
                    style: batchDailogTextStyle,
                  )),
              TextButton(
                  onPressed: () {
                    context.pop(context);
                    _deleteDailogBuilder(context, batch);
                  },
                  child: const Text(
                    'Delete Batch',
                    style: batchDailogTextStyle,
                  )),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Brodcast Message',
                    style: batchDailogTextStyle,
                  )),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Send Attendance',
                    style: batchDailogTextStyle,
                  )),
            ],
          ),
        );
      },
    );
  }

  static Future<dynamic> batchInfo(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              contentPadding:
                  const EdgeInsets.only(top: 10, left: 10, right: 70),
              titlePadding: const EdgeInsets.only(left: 70),
              shape: Border.all(width: 2, color: Colors.transparent),
              title: const Text('Batch Name'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
batchInfoTile('Total Students', '0', Colors.blue),
                  batchInfoTile('Inactive Students', '0', Colors.red),
                  batchInfoTile('Total Inactive', '0', Colors.blue),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 60.0, top: 10, bottom: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                        onPressed: () {
                          context.pop(context);
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textScaler: TextScaler.linear(1.2),
                        )),
                  ),
                ],
              ),
            ));
  }

  static Row batchInfoTile(String title, String value, Color color) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: color,
        ),
        textScaler: const TextScaler.linear(1.3),
      ),
      Text(
        value,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        textScaler: const TextScaler.linear(1.3),
      ),
    ]);
  }

  static Future<dynamic> _deleteDailogBuilder(
      BuildContext context, BatchModel batch) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(15),
            shape: Border.all(width: 2, color: Colors.transparent),
            title: const Row(
              children: [
                Icon(
                  Icons.delete_forever,
                  color: Color.fromARGB(255, 3, 118, 153),
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Do you want to Delete',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaler: TextScaler.linear(.9)),
              ],
            ),
            content: const Text(
                'This will delete all the students those belongs to this batch !!!'),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('CANCEL'),
                onPressed: () {
                  context.pop(context);
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('DELETE'),
                onPressed: () {
                  context
                      .read<BatchBloc>()
                      .add(DeleteBatchEvent(batch.batchId!));
                  context.pop(context);
                },
              ),
            ],
          );
        });
  }
}
