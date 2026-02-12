import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final List<Widget> items;

  const Sidebar({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(child: ListView(children: items));
  }
}
