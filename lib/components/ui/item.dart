import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final Widget child;

  const ItemWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(title: child);
  }
}
