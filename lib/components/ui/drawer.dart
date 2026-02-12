import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final Widget child;

  const CustomDrawer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: child,
    );
  }
}
