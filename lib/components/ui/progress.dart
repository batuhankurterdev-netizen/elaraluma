import 'package:flutter/material.dart';

class ProgressWidget extends StatelessWidget {
  final double value;

  const ProgressWidget({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(value: value);
  }
}
