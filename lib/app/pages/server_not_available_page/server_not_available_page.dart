import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServerNotAvailablePage extends StatelessWidget {
  const ServerNotAvailablePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(FontAwesomeIcons.triangleExclamation, size: 100, color: Colors.white),
            SizedBox(height: 50),
            Text(
              "Sunucuya Bağlanılamadı",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
                color: Colors.white
              ),
            ),
          ],
        ),
      ),
    );
  }
}
