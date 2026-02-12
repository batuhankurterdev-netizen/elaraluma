import 'package:flutter/material.dart';

class InputGroup extends StatelessWidget {
  final List<Widget> children;

  const InputGroup({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: children);
  }
}
