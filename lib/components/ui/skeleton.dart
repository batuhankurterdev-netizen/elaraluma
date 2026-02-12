import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  final double height;
  final double width;

  const Skeleton({Key? key, this.height = 12, this.width = double.infinity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: Colors.grey.shade300,
    );
  }
}
