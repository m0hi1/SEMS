import 'package:sems/features/Todo/bloc/todo_bloc.dart';
import 'package:sems/features/Todo/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTask extends StatefulWidget {
  final TodoModel? task;
  const NewTask({super.key, this.task});

  @override
  _NewTaskScreenState createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTask> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController taskNameController;
  late final TextEditingController remarksController;
  late final TextEditingController dueDateController;
  late final TextEditingController dueTimeController;

  String _priority = 'High'; // Default priority
  String _repeat = 'No Repeat'; // Default repeat value
  String _taskType = 'Default'; // Default task type

  @override
  void initState() {
    super.initState();
    _initializeControllers();

    if (widget.task != null) {
      taskNameController.text = widget.task!.taskDescription;
      remarksController.text = widget.task!.remarks;
      dueDateController.text = widget.task!.dueDate;
      dueTimeController.text = widget.task!.dueTime;
      _priority = widget.task!.priority;
      _repeat = widget.task!.repeat;
      _taskType = widget.task!.taskType;
    }
  }

  void _initializeControllers() {
    taskNameController = TextEditingController();
    remarksController = TextEditingController();
    dueDateController = TextEditingController();
    dueTimeController = TextEditingController();
  }

  @override
  void dispose() {
    taskNameController.dispose();
    remarksController.dispose();
    dueDateController.dispose();
    dueTimeController.dispose();
    super.dispose();
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        dueDateController.text =
            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      });
    }
  }

  Future<void> _selectDueTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        dueTimeController.text = pickedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: taskNameController,
                decoration: const InputDecoration(
                  labelText: 'What is to be done?',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: remarksController,
                decoration: const InputDecoration(
                  labelText: 'Remarks',
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Priority',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Low',
                    groupValue: _priority,
                    onChanged: (value) {
                      setState(() {
                        _priority = value!;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                  const Text('Low'),
                  Radio<String>(
                    value: 'Medium',
                    groupValue: _priority,
                    onChanged: (value) {
                      setState(() {
                        _priority = value!;
                      });
                    },
                    activeColor: Colors.orange,
                  ),
                  const Text('Medium'),
                  Radio<String>(
                    value: 'High',
                    groupValue: _priority,
                    onChanged: (value) {
                      setState(() {
                        _priority = value!;
                      });
                    },
                    activeColor: Colors.red,
                  ),
                  const Text('High'),
                ],
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: dueDateController,
                decoration: const InputDecoration(
                  labelText: 'Due Date',
                ),
                readOnly: true,
                onTap: () => _selectDueDate(context),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: dueTimeController,
                decoration: const InputDecoration(
                  labelText: 'Due Time',
                ),
                readOnly: true,
                onTap: () => _selectDueTime(context),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Repeat',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: _repeat,
                onChanged: (String? newValue) {
                  setState(() {
                    _repeat = newValue!;
                  });
                },
                items: <String>[
                  'No Repeat',
                  'Once a Day',
                  'Once a Week',
                  'Once a Month',
                  'Once a Year'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Task Type',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: _taskType,
                onChanged: (String? newValue) {
                  setState(() {
                    _taskType = newValue!;
                  });
                },
                items: <String>[
                  'Default',
                  'Free Collection',
                  'Personal',
                  'Take Exam',
                  'Wish List',
                  'OTHER'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final task = TodoModel(
                        taskDescription: taskNameController.text,
                        remarks: remarksController.text,
                        priority: _priority,
                        dueDate: dueDateController.text,
                        dueTime: dueTimeController.text,
                        repeat: _repeat,
                        taskType: _taskType,
                      );
                      context.read<TodoBloc>().add(AddTodoEvent(task));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Task Added Successfully'),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                  child: const Text('SAVE'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
