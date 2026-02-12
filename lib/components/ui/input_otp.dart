import 'package:flutter/material.dart';

class InputOtp extends StatelessWidget {
  final int length;
  final ValueChanged<String>? onChanged;

  const InputOtp({Key? key, this.length = 4, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) => SizedBox(width: 40, child: TextFormField(textAlign: TextAlign.center))),
    );
  }
}
