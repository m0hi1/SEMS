import 'package:flutter/material.dart';

class StudentDropdown extends StatefulWidget {
  final List<String> list;
  final ValueChanged<String> onChanged;
  const StudentDropdown(
      {super.key, required this.list, required this.onChanged});

  @override
  State<StudentDropdown> createState() => _StudentDropdownState();
}

class _StudentDropdownState extends State<StudentDropdown> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.list[0];
    // widget.onChanged(widget.list[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: DropdownButton<String>(
        isExpanded: true,
        menuWidth: 350,
        value: dropdownValue,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        style: const TextStyle(color: Colors.blue, fontSize: 20),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
            widget.onChanged(value);
          });
        },
        underline: Container(),
        items: widget.list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
