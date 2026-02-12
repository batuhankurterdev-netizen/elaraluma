import 'package:flutter/material.dart';

class CustomButtonGroup extends StatelessWidget {
  final List<Widget> buttons;

  const CustomButtonGroup({Key? key, required this.buttons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buttons,
    );
  }
}
