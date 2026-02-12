import 'package:flutter/material.dart';

class TabsWidget extends StatelessWidget {
  final List<Tab> tabs;
  final List<Widget> views;

  const TabsWidget({Key? key, required this.tabs, required this.views}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          TabBar(tabs: tabs),
          SizedBox(height: 300, child: TabBarView(children: views)),
        ],
      ),
    );
  }
}
