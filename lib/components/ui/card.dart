import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget? header;
  final Widget? title;
  final Widget? description;
  final Widget? child;

  const CustomCard({
    Key? key,
    this.header,
    this.title,
    this.description,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (header != null) header!,
            if (title != null) title!,
            if (description != null) description!,
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
