import 'package:flutter/material.dart';

class CustomTextarea extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final int maxLines;

  const CustomTextarea({Key? key, this.hint, this.controller, this.maxLines = 5}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(hintText: hint, border: OutlineInputBorder()),
    );
  }
}
