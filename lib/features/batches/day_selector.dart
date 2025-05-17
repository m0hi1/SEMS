import 'package:flutter/material.dart';

class SelectDayCard extends StatefulWidget {
  final List<String> days;
  final String day;

  const SelectDayCard({
    super.key,
    required this.day,
    required this.days,
  });

  @override
  State<SelectDayCard> createState() => _SelectDayCardState();
}

class _SelectDayCardState extends State<SelectDayCard> {
  bool isSelected = false;
  @override
  void initState() {
    super.initState();
    isSelected = widget.days.contains(widget.day);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          if (widget.days.contains(widget.day)) {
            widget.days.remove(widget.day);
          } else {
            widget.days.add(widget.day);
          }
          isSelected = widget.days.contains(widget.day);

          print(widget.days);
        });
      },
      child: Container(
          // margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 2), // (5),
          decoration: BoxDecoration(
            color: !isSelected ? Colors.grey : Colors.blue,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Text(
            widget.day,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
}
