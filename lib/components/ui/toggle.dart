import 'package:flutter/material.dart';

class ToggleButtonWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const ToggleButtonWidget({Key? key, required this.value, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(value ? Icons.toggle_on : Icons.toggle_off, size: 32),
      onPressed: () => onChanged?.call(!value),
    );
  }
}
