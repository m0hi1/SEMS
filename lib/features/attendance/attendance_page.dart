import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sems/features/attendance/attendance_batch_card.dart';
import 'package:sems/features/attendance/take_Attendence_view.dart';
import 'package:sems/features/batches/bloc/batch_bloc.dart';
import 'package:sems/shared/utils/cutom_appbar.dart';

import 'bloc/attendance_bloc.dart' as at;

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  Map<String, int> attendanceMap = {};
  int present = 0;
  int absent = 0;
  int leave = 0;

  @override
  void initState() {
    super.initState();
    _fetchAttendance();
  }

  void _fetchAttendance() {
    context
        .read<at.AttendanceBloc>()
        .add(at.GetAttendancesEvent(formatDate(DateTime.now())));
  }

  void _updateAttendanceCounts(String? attendanceData) {
    if (attendanceData == null) return;

    setState(() {
      // Reset counts before processing new data
      present = 0;
      absent = 0;
      leave = 0;

      for (var attended in attendanceData.split(',')) {
        final parts = attended.split(':');
        if (parts.length < 2) continue;

        final attendStatus = parts.last.trim();
        switch (attendStatus) {
          case '3':
            present++;
            break;
          case '4':
            absent++;
            break;
          case '2':
            leave++;
            break;
          default:
            debugPrint("Unknown attendance status: $attendStatus");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final batchBloc = context.read<BatchBloc>();

    return SafeArea(
      child: Scaffold(
        appBar: MyCustomAppBar(
          title: 'Select Batch',
          bloc: batchBloc,
          onSearch: (searchQuery) => SearchBatchEvent(searchQuery),
        ),
        body: SingleChildScrollView(
          child: MultiBlocListener(
            listeners: [
              BlocListener<at.AttendanceBloc, at.AttendanceState>(
                listener: (context, state) {
                  if (state is at.AttendanceLoaded) {
                    _updateAttendanceCounts(state.attendance.attendances);
                  }
                },
              ),
            ],
            child: BlocConsumer<BatchBloc, BatchState>(
              listener: (context, state) {
                if (state is FailureState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is BatchLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is BatchLoaded) {
                  if (state.batches.isEmpty) {
                    return const Center(child: Text("No Batches Found"));
                  }

                  return Column(
                    children: state.batches
                        .map((batch) => AttendanceBatchCard(
                              batch: batch,
                              present: present,
                              absent: absent,
                              leave: leave,
                            ))
                        .toList(),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
