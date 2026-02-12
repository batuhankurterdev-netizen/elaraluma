import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const CustomSwitch({Key? key, required this.value, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(value: value, onChanged: onChanged ?? (_) {});
  }
}
