import 'package:flutter/material.dart';

class CustomSelect<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;

  const CustomSelect({Key? key, this.value, required this.items, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(value: value, items: items, onChanged: onChanged);
  }
}
