import 'package:flutter/material.dart';

class CustomEmpty extends StatelessWidget {
  final String message;

  const CustomEmpty({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.grey, fontSize: 16),
      ),
    );
  }
}
