import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sems/shared/utils/logger.dart';

import '../../shared/utils/cutom_appbar.dart';
import '../bloc/student_bloc.dart';
import '../utils/batch_selector.dart';
import '../utils/student_card.dart';

class ActiveStudentsList extends StatefulWidget {
  const ActiveStudentsList({super.key});

  @override
  State<ActiveStudentsList> createState() => _ActiveStudentsListState();
}

class _ActiveStudentsListState extends State<ActiveStudentsList> {
  bool isSearchFieldVisible = false;
  String selectedBatchName = 'All';

  @override
  void initState() {
    super.initState();
    context.read<StudentBloc>().add(GetStudentListEvent());
  }

  @override
  Widget build(BuildContext context) {
    final StudentBloc studentBloc = context.read<StudentBloc>();
    return SafeArea(
      child: Scaffold(
        appBar: MyCustomAppBar(
          title: 'Students',
          bloc: studentBloc,
          onSearch: (searchQuery) => GetSearchedStudentListEvent(
            studentName: searchQuery,
            isActive: true,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.info,
                color: Colors.white,
              ),
              iconSize: 35,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            BatchSelector(
              onBatchSelected: (value) {
                selectedBatchName = value!;
                if (value == 'All') {
                  context.read<StudentBloc>().add(GetStudentListEvent());
                }
                context.read<StudentBloc>().add(
                    GetFilteredStudentListEvent(batch: value, isActive: true));
              },
              initialValue: selectedBatchName,
            ),
            BlocConsumer<StudentBloc, StudentState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is StudentLoaded) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.students.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  spreadRadius: 2)
                            ],
                            // borderRadius: BorderRadius.all(Radius.circular(0)),
                          ),
                          child: StudentCard(
                            student: state.students[index],
                          ),
                        );
                      },
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 57, 2, 129),
          shape: const CircleBorder(),
          onPressed: () {},
          child: const Icon(
            Icons.send,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
