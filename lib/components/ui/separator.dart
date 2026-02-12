import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  final double thickness;

  const Separator({Key? key, this.thickness = 1.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(thickness: thickness);
  }
}
