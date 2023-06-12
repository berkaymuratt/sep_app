import 'package:flutter/material.dart';

class SepDivider extends StatelessWidget {
  final double height;
  final double width;
  final Color color;

  const SepDivider({Key? key, required this.height, required this.width, this.color = Colors.grey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: color,
      child: const Text(""),
    );
  }
}
