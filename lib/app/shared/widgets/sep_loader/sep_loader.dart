import 'package:flutter/material.dart';
import 'package:sep_app/app/shared/sep_colors.dart';

class SepLoader extends StatelessWidget {
  const SepLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: SepColors.primaryColor,
    );
  }
}
