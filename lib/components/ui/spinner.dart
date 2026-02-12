import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {
  final double size;

  const Spinner({Key? key, this.size = 24}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size, height: size, child: const CircularProgressIndicator());
  }
}
