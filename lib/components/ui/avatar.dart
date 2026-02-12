import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const CustomAvatar({Key? key, required this.imageUrl, this.radius = 24}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(imageUrl),
      radius: radius,
    );
  }
}
