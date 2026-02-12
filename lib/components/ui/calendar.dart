import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatelessWidget {
  final CalendarFormat format;
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final Function(DateTime, DateTime)? onDaySelected;

  const CustomCalendar({
    Key? key,
    this.format = CalendarFormat.month,
    required this.focusedDay,
    this.selectedDay,
    this.onDaySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarFormat: format,
      focusedDay: focusedDay,
      selectedDayPredicate: (day) => day == selectedDay,
      onDaySelected: onDaySelected,
      firstDay: DateTime.utc(2000, 1, 1),
      lastDay: DateTime.utc(2100, 12, 31),
    );
  }
}
