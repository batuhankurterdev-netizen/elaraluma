import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final List<Widget> children;

  const CustomForm({Key? key, this.formKey, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(key: formKey, child: Column(children: children));
  }
}
