import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  final double value;
  final ValueChanged<double>? onChanged;

  const SliderWidget({Key? key, required this.value, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slider(value: value, onChanged: onChanged ?? (_) {});
  }
}
