import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sems/shared/utils/logger.dart';

import '../../features/batches/bloc/batch_bloc.dart';
import 'student_dropdown.dart';

class BatchSelector extends StatelessWidget {
  final ValueChanged<String?> onBatchSelected;
  final String initialValue;

  const BatchSelector({
    super.key,
    required this.initialValue,
    required this.onBatchSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BatchBloc, BatchState>(
      builder: (context, state) {
        List<String> list = [initialValue];
        if (state is BatchLoaded) {
          final List<String> tempList =
              state.batches.map((e) => e.batchName).toList();
          list.addAll(tempList);
        }

        return StudentDropdown(
          list: list,
          onChanged: (value) {
            onBatchSelected(value);
          },
        );
      },
    );
  }
}
