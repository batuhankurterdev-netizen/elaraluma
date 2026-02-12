import 'package:flutter/material.dart';

class CustomContextMenu extends StatelessWidget {
  final Widget child;
  final List<PopupMenuEntry> menuItems;

  const CustomContextMenu({Key? key, required this.child, required this.menuItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(100, 100, 100, 100),
          items: menuItems,
        );
      },
      child: child,
    );
  }
}
