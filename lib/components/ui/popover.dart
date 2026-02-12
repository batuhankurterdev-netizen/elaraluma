import 'package:flutter/material.dart';

class PopoverWidget extends StatelessWidget {
  final Widget child;
  final Widget content;

  const PopoverWidget({Key? key, required this.child, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (_) => Dialog(child: content));
      },
      child: child,
    );
  }
}
