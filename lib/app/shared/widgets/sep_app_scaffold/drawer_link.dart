import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerLink extends StatelessWidget {
  final IconData prefixIcon;
  final String title;
  final String path;

  const DrawerLink({
    Key? key,
    required this.title,
    required this.prefixIcon,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: GestureDetector(
        onTap: () {
          debugPrint("selected link: $path");
          // TODO: Implement Navigation
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
