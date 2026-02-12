import 'package:flutter/material.dart';

class SimpleTable extends StatelessWidget {
  final List<List<Widget>> rows;

  const SimpleTable({Key? key, required this.rows}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      children: rows.map((r) => TableRow(children: r)).toList(),
    );
  }
}
