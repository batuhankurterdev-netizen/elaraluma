import 'package:flutter/material.dart';

class PaginationWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int>? onPageChanged;

  const PaginationWidget({Key? key, required this.currentPage, required this.totalPages, this.onPageChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: currentPage>1?() => onPageChanged?.call(currentPage-1):null, icon: Icon(Icons.chevron_left)),
        Text('$currentPage / $totalPages'),
        IconButton(onPressed: currentPage<totalPages?() => onPageChanged?.call(currentPage+1):null, icon: Icon(Icons.chevron_right)),
      ],
    );
  }
}
