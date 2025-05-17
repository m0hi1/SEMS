import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../router.dart';
import '../../../shared/utils/cutom_appbar.dart';
import '../../batches/batch_card.dart';
import '../../batches/bloc/batch_bloc.dart';

class AddFees extends StatefulWidget {
  const AddFees({super.key});

  @override
  State<AddFees> createState() => _AddFeesState();
}

class _AddFeesState extends State<AddFees> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<BatchBloc, BatchState>(
        listener: (context, state) {
          if (state is BatchLoaded && state.batches.isEmpty) {
            // Show alert dialog if batch list is empty
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text(
                  "Batch List is Empty.Please add Batch First.",
                  style: TextStyle(fontSize: 15),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("OK"),
                  ),
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(248, 255, 255, 255),
            appBar: const MyCustomAppBar(
              title: 'Batches List',
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state is BatchLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                if (state is BatchLoaded && state.batches.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.batches.length,
                      itemBuilder: (context, index) {
                        return BatchesCard(
                          batch: state.batches[index],
                        );
                      },
                    ),
                  ),
                if (state is FailureState)
                  Center(
                    child: Text(state.message),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
