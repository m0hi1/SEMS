import 'package:sems/router.dart';
import 'package:sems/features/Todo/bloc/todo_bloc.dart';
import 'package:sems/features/Todo/taskcard.dart';

import 'package:sems/shared/utils/cutom_appbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class todoHome extends StatefulWidget {
  const todoHome({super.key});

  @override
  State<todoHome> createState() => _TodoListState();
}

class _TodoListState extends State<todoHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(248, 255, 255, 255),
            appBar: const MyCustomAppBar(
              isSearchIconVisible: false,
              title: 'To Do Task List',
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tab + to Add New Tasks',
                  style: TextStyle(color: Color.fromARGB(255, 116, 116, 116)),
                  textScaler: TextScaler.linear(1.1),
                ),
                if (state is TodoLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                if (state is TodoLoaded)
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        return Taskcard(task: state.tasks[index]);
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
                  context.push(AppRoute.todonewtask.path);
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
