import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  void initState() {
    super.initState();
    navigateToLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

  void navigateToLogin(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      context.go("/login");
    });
  }
}
