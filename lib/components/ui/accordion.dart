import 'package:flutter/material.dart';

class CustomAccordion extends StatelessWidget {
  final List<Widget> children;
  const CustomAccordion({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {},
      children: children.map((child) {
        return ExpansionPanel(
          headerBuilder: (context, isExpanded) => child,
          body: Container(),
          isExpanded: false,
        );
      }).toList(),
    );
  }
}
