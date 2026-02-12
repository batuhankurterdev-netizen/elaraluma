import 'package:flutter/material.dart';

class CustomBreadcrumb extends StatelessWidget {
  final List<String> items;

  const CustomBreadcrumb({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: items
          .map((item) => Row(
                children: [
                  Text(item),
                  if (item != items.last) Icon(Icons.chevron_right, size: 16),
                ],
              ))
          .toList(),
    );
  }
}
