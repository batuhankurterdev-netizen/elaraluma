import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;

  const CustomInput({Key? key, this.hint, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(controller: controller, decoration: InputDecoration(hintText: hint));
  }
}
