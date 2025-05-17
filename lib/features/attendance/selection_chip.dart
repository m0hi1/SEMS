import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sems/student/model/student_model.dart';

import '../../shared/utils/show_dailog_box.dart';

class SelectionChipCard extends StatefulWidget {
  const SelectionChipCard({
    super.key,
    required this.initialValues,
    this.students,
    this.rollNo,
    this.onAllValuesUpdated,
  });

  final Map<String, int> initialValues;
  final String? rollNo;
  final List<Student>? students;
  final VoidCallback? onAllValuesUpdated;

  @override
  State<SelectionChipCard> createState() => _SelectionChipCardState();
}

class _SelectionChipCardState extends State<SelectionChipCard> {
  bool isAllChanged = false;
  final List<String> selectionOptions = [
    "Not Set",
    "Holiday",
    "Leave",
    "Present",
    "Absent"
  ];
  late int _value;

  @override
  void initState() {
    super.initState();
    _initializeValue();
  }

  @override
  void didUpdateWidget(covariant SelectionChipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if (widget.initialValues != oldWidget.initialValues) {
    _initializeValue();
    // }
  }

  void _initializeValue() {
    setState(() {
      if (widget.rollNo != null && widget.initialValues.isNotEmpty) {
        _value = widget.initialValues[widget.rollNo] ?? 0;
      } else if (isAllChanged) {
        _value = widget.initialValues.values.first;
      } else {
        _value = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: selectionOptions.asMap().entries.map((entry) {
        int index = entry.key;
        String option = entry.value;

        return ChoiceChip(
          shape: _buildChipShape(index),
          showCheckmark: false,
          selectedColor: Colors.blue,
          label: Text(
            option,
            style: TextStyle(
              color: _value == index ? Colors.white : Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
          selected: _value == index,
          onSelected: (bool selected) {
            if (selected) {
              _onChipSelected(index);
            }
          },
        );
      }).toList(),
    );
  }

  OutlinedBorder _buildChipShape(int index) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: index == 0 ? const Radius.circular(8) : Radius.zero,
        bottomLeft: index == 0 ? const Radius.circular(8) : Radius.zero,
        topRight: index == selectionOptions.length - 1
            ? const Radius.circular(8)
            : Radius.zero,
        bottomRight: index == selectionOptions.length - 1
            ? const Radius.circular(8)
            : Radius.zero,
      ),
      side: const BorderSide(
        color: Colors.blue,
        width: 1.8,
        strokeAlign: BorderSide.strokeAlignCenter,
      ),
    );
  }

  void _onChipSelected(int index) {
    if (widget.students != null) {
      _showConfirmationDialog(index);
    } else {
      _updateValue(index);
    }
  }

  void _showConfirmationDialog(int index) {
    dialogBuilder(
      context,
      AlertDialog(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(),
        insetPadding: const EdgeInsets.symmetric(horizontal: 25),
        title: const Text(
          "Set to all",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        content: Text(
          "Do you really want to set status '${selectionOptions[index]}' to all students of the selected batch?",
          style: const TextStyle(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              "NO",
              style: TextStyle(color: Colors.lightBlue[900], fontSize: 15),
            ),
          ),
          TextButton(
            onPressed: () {
              _updateAllStudents(index);
              context.pop();
            },
            child: Text(
              "YES",
              style: TextStyle(color: Colors.lightBlue[900], fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  void _updateAllStudents(int index) {
    setState(() {
      _value = index;
      isAllChanged = true;

      for (var student in widget.students!) {
        widget.initialValues[student.rollNumber] = _value;
      }
    });
    if (widget.onAllValuesUpdated != null) {
      widget.onAllValuesUpdated!();
    }
  }

  void _updateValue(int index) {
    setState(() {
      _value = index;
      if (widget.rollNo != null) {
        widget.initialValues[widget.rollNo!] = _value;
      }
    });
  }
}
