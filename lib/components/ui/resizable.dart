import 'package:flutter/material.dart';

class ResizableBox extends StatefulWidget {
  final Widget child;

  const ResizableBox({Key? key, required this.child}) : super(key: key);

  @override
  State<ResizableBox> createState() => _ResizableBoxState();
}

class _ResizableBoxState extends State<ResizableBox> {
  double _width = 200;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (e) => setState(() => _width += e.delta.dx),
      child: Container(width: _width, child: widget.child),
    );
  }
}
