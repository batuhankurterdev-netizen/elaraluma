import 'package:flutter/material.dart';

class CustomCommand extends StatelessWidget {
  final String command;
  final VoidCallback? onExecute;

  const CustomCommand({Key? key, required this.command, this.onExecute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onExecute,
      child: Text(command),
    );
  }
}
