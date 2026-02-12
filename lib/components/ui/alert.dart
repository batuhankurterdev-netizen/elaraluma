import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback? onOk;

  const CustomAlert({Key? key, required this.title, required this.content, this.onOk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onOk ?? () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
