import 'package:flutter/material.dart';

class ScrollArea extends StatelessWidget {
  final Widget child;

  const ScrollArea({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: child);
  }
}
