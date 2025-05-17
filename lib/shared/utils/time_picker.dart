import 'package:flutter/material.dart';
import 'package:sems/shared/utils/custom_textfield.dart';

class CustomTimePicker extends StatefulWidget {
  final TextEditingController timeController;
  const CustomTimePicker({super.key, required this.timeController});

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
        widget.timeController.text = _selectedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectTime(context),
      child: CustomTextField(
        title: 'Batch Time',
        controller: widget.timeController,
        isDisabled: true,
      ),
    );
  }
}
