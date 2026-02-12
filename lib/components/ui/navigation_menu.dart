import 'package:flutter/material.dart';

class NavigationMenu extends StatelessWidget {
  final List<Widget> items;

  const NavigationMenu({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: items);
  }
}
