import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final ValueChanged<String>? onChanged;

  const CustomField({Key? key, required this.label, this.initialValue, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
    );
  }
}
