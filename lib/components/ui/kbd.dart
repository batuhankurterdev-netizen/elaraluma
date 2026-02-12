import 'package:flutter/material.dart';

class Kbd extends StatelessWidget {
  final String label;

  const Kbd({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4)),
      child: Text(label, style: const TextStyle(fontFamily: 'monospace')),
    );
  }
}
