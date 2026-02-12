import 'package:flutter/material.dart';

class ToggleGroup<T> extends StatelessWidget {
  final List<T> values;
  final T selected;
  final ValueChanged<T>? onChanged;

  const ToggleGroup({Key? key, required this.values, required this.selected, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: values.map((v) {
        final active = v == selected;
        return ChoiceChip(
          label: Text(v.toString()),
          selected: active,
          onSelected: (_) => onChanged?.call(v),
        );
      }).toList(),
    );
  }
}
