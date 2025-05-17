import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<DateTime?> pickDate(
    BuildContext context, TextEditingController controller,
    {bool? isLastDate = false}) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: controller.text.isNotEmpty
        ? DateTime.tryParse(controller.text)
        : DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: isLastDate! ? DateTime.now() : DateTime(2101),
  );
  if (picked != null) {
    controller.text = DateFormat('yyyy-MM-dd').format(picked);
  }
  return picked;
}
