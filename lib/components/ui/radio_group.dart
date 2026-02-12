import 'package:flutter/material.dart';

class RadioGroup<T> extends StatelessWidget {
  final T value;
  final ValueChanged<T?>? onChanged;
  final List<Widget> children;

  const RadioGroup({Key? key, required this.value, this.onChanged, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: children);
  }
}
