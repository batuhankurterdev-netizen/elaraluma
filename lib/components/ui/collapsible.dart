import 'package:flutter/material.dart';

class CustomCollapsible extends StatefulWidget {
  final Widget child;
  final bool collapsed;

  const CustomCollapsible({Key? key, required this.child, this.collapsed = false}) : super(key: key);

  @override
  State<CustomCollapsible> createState() => _CustomCollapsibleState();
}

class _CustomCollapsibleState extends State<CustomCollapsible> {
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: widget.child,
      secondChild: SizedBox.shrink(),
      crossFadeState: widget.collapsed ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 300),
    );
  }
}
