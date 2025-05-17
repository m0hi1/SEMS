import 'package:sems/router.dart';
import 'package:sems/features/batches/batch_card.dart';
import 'package:sems/features/batches/batch_model.dart';
import 'package:sems/features/batches/bloc/batch_bloc.dart';
import 'package:sems/shared/utils/cutom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BatchesList extends StatefulWidget {
  const BatchesList({super.key});

  @override
  State<BatchesList> createState() => _BatchesListState();
}

class _BatchesListState extends State<BatchesList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BatchBloc>();
    return SafeArea(
      child: BlocConsumer<BatchBloc, BatchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(248, 255, 255, 255),
            appBar: MyCustomAppBar(
              title: 'Batches List',
              bloc: bloc,
              onSearch: (searchQuery) => SearchBatchEvent(searchQuery),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Please Tab on Add Button to Add New Batches',
                  style: TextStyle(color: Color.fromARGB(255, 116, 116, 116)),
                  textScaler: TextScaler.linear(1.1),
                ),
                if (state is BatchLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                if (state is BatchLoaded)
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
            floatingActionButton: Transform.scale(
              //this is to scale the button if want to
              scale: 1,
              child: FloatingActionButton(
                materialTapTargetSize: MaterialTapTargetSize.padded,
                backgroundColor: const Color.fromARGB(255, 3, 65, 158),
                shape: const CircleBorder(),
                onPressed: () {
                  context.push(AppRoute.newBatch.path);
                },
                child: const Icon(
                  Icons.add,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
