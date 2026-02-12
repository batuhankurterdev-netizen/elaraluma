import 'package:flutter/material.dart';

class Sonner {
  static void show(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(content: Text(message)));
  }
}
