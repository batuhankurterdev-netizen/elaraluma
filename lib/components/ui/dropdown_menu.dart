import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?>? onChanged;

  const CustomDropdownMenu({Key? key, required this.items, this.selectedItem, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedItem,
      items: items.map((item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      )).toList(),
      onChanged: onChanged,
    );
  }
}
