import 'package:flutter/material.dart';

class HoverCard extends StatelessWidget {
  final Widget child;

  const HoverCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Card(child: child),
    );
  }
}
