import 'package:flutter/material.dart';

class CustomChart extends StatelessWidget {
  final Widget chartWidget;

  const CustomChart({Key? key, required this.chartWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: chartWidget,
    );
  }
}
