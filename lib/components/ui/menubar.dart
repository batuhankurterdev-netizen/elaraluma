import 'package:flutter/material.dart';

class MenuBarWidget extends StatelessWidget {
  final List<Widget> items;

  const MenuBarWidget({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: items);
  }
}
