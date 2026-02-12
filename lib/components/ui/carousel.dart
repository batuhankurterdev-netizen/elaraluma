import 'package:flutter/material.dart';

class CustomCarousel extends StatelessWidget {
  final List<Widget> items;
  final PageController? controller;

  const CustomCarousel({Key? key, required this.items, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView(
        controller: controller,
        children: items,
      ),
    );
  }
}
