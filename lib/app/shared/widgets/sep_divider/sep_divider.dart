import 'package:flutter/material.dart';

class SepDivider extends StatelessWidget {
  final double height;
  final double width;

  const SepDivider({Key? key, required this.height, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: Colors.grey,
      child: const Text(""),
    );
  }
}
