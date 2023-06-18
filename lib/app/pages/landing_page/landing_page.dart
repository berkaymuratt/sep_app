import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sep_app/app/shared/view_models/auth_view_model.dart';
import 'package:sep_app/app/shared/sep_app_scaffold/sep_app_scaffold.dart';
import 'package:sep_app/app/shared/widgets/sep_loader/sep_loader.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthViewModel>().loginAsPatient("12345678911", "ayse123").then((patient) {
        if (patient == null) {
          context.go("/server-not-available");
        } else {
          navigateToHome(context);
        }
      });
    });
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

  void navigateToHome(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      context.go("/home");
    });
  }
}
