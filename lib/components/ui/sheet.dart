import 'package:flutter/material.dart';

class SheetWidget extends StatelessWidget {
  final Widget child;

  const SheetWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (context, controller) => Container(
        color: Theme.of(context).canvasColor,
        child: SingleChildScrollView(controller: controller, child: child),
      ),
    );
  }
}
