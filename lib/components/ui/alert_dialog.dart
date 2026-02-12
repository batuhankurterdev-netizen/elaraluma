import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final Widget title;
  final Widget content;
  final List<Widget>? actions;

  const CustomAlertDialog({Key? key, required this.title, required this.content, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(title: title, content: content, actions: actions);
  }
}
