import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  final String text;

  const LabelWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontWeight: FontWeight.w600));
  }
}
