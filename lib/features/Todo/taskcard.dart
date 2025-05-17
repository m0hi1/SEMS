import 'package:sems/router.dart';
import 'package:sems/features/Todo/bloc/todo_bloc.dart';
import 'package:sems/features/Todo/todo_model.dart';
import 'package:sems/features/batches/batch_model.dart';
import 'package:sems/features/batches/bloc/batch_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class Taskcard extends StatelessWidget {
  final TodoModel task;
  const Taskcard({
    super.key,
    required this.task,
  });

  String getDateText() {
    final DateTime now = DateTime.now();

    /// final DateTime taskDate = DateFormat('yyyy-MM-dd').parse(task.dueDate);
    final DateTime taskDate;
    try {
      if (task.dueDate.isEmpty) {
        return 'No due date';
      }
      taskDate = DateFormat('yyyy-MM-dd').parse(task.dueDate);
    } catch (e) {
      return 'Invalid date';
    }
    if (taskDate.year == now.year &&
        taskDate.month == now.month &&
        taskDate.day == now.day) {
      return 'Today';
    } else if (taskDate.year == now.year &&
        taskDate.month == now.month &&
        taskDate.day == now.day + 1) {
      return 'Tomorrow';
    } else {
      return 'Upcoming';
    }
  }

  Color getLineColor() {
    // Example logic to decide color, adjust as per your requirements
    if (task.priority == "Low") {
      return Colors.blue;
    } else if (task.priority == "Medium") {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0), // Add some padding
          child: Text(
            getDateText(), // Display Today, Tomorrow, or Upcoming
            style: TextStyle(
              fontSize: 17,
              color: getLineColor(),
              fontWeight: FontWeight.bold, // Make the text bold
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _otherMethod(context); // Call a different method on InkWell tap
          },
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2)
              ],
              borderRadius: BorderRadius.all(Radius.circular(9)),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 61,
                      color: getLineColor(), // Dynamic line color
                      //color: Colors.orange,
                    ),
                    Expanded(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(2),
                        leading: Checkbox(
                          value: task
                              .isSelected, // Assumes you have an isSelected field
                          onChanged: (bool? value) {
                            task.isSelected =
                                value ?? false; // Toggle checkbox selection
                            _dialogBuilder(
                                context, task); // Open dialog on checkbox tap
                          },
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.taskDescription, // Display Today, Tomorrow, or Upcoming
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Text(
                                  task.dueDate,
                                  style: TextStyle(color: getLineColor()),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  task.dueTime,
                                  style: TextStyle(color: getLineColor()),
                                ),
                                const Spacer(),
                                Text(task.repeat),
                                const Spacer(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static Future<dynamic> _dialogBuilder(
    BuildContext context,
    TodoModel task,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Finish Task?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(false); // Return false if "NO" is clicked
              },
              child: const Text('NO'),
            ),
            TextButton(
              onPressed: () {
                context.read<TodoBloc>().add(DeleteTodoEvent(task.taskId!));
                context.pop(context);
              },
              child: const Text('YES'),
            ),
          ],
        );
      },
    );
  }

  void _otherMethod(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Center(
            child: Text(
              task.taskDescription, // Dynamic title of the task
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Remarks",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      task.remarks, // Dynamic remarks for the task
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    "Priority",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      task.priority, // Dynamic priority level
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    "Task Type",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      task.taskType, // Dynamic task type
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "OK",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
