import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class DrawerLink extends StatelessWidget {
  final IconData prefixIcon;
  final String title;
  final String path;
  Function()? onPressed;

  DrawerLink({
    Key? key,
    required this.title,
    required this.prefixIcon,
    required this.path,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: GestureDetector(
        onTap: () {
          if (onPressed != null) {
            onPressed!();
          }

          context.go(path);
        },
        child: Row(
          children: [
            FaIcon(prefixIcon),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(title),
            ),
          ],
        ),
      ),
    );
  }
}
