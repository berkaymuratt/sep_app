import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sep_app/app/shared/modals/sign_up_modal/sign_up_modal.dart';
import 'package:sep_app/app/shared/modals/sign_up_modal/sign_up_modal_view_model.dart';
import 'package:sep_app/app/shared/sep_toast_messages.dart';
import 'package:sep_app/app/shared/view_models/auth_view_model.dart';
import 'package:sep_app/app/shared/widgets/sep_divider/sep_divider.dart';

class LoginPage extends StatelessWidget {
  String userId = "";
  String password = "";

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();

    return Theme(
      data: ThemeData(
        primarySwatch: Colors.green,
      ),
      child: Scaffold(
        backgroundColor: Colors.redAccent,
        body: authViewModel.isStateLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white))
            : ListView(
                children: [
                  const SizedBox(height: 20),
                  _header(context),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 35),
                    child:
                        SepDivider(height: 2, width: 150, color: Colors.white),
                  ),
                  const SizedBox(height: 30),
                  _loginInputField(context),
                ],
              ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(300)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54.withOpacity(0.4),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 15 / 100,
              width: MediaQuery.of(context).size.height * 15 / 100,
              child: Image.asset("assets/images/heart.png"),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "SEP",
            style: TextStyle(
              fontFamily: 'SoftFont',
              fontSize: 35,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginInputField(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, right: 10, left: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black54.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      height: 350,
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.hospitalUser, color: Colors.red),
              SizedBox(width: 10),
              Text(
                "Hasta Girişi",
                style: TextStyle(
                  color: Colors.red,
                  // fontFamily: 'SoftFont',
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SepDivider(height: 2, width: 500),
          ),
          const SizedBox(height: 50),
          _inputField(context),
          const SizedBox(height: 32.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _loginButton(context),
              _registerButton(context),
            ],
          ),
        ],
      ),
    );
  }

  MaterialButton _loginButton(BuildContext context) {
    return MaterialButton(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          onPressed: () => _signIn(context),
          color: Colors.red,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.signIn, size: 15, color: Colors.white),
              SizedBox(width: 5.0),
              Text(
                'Giriş Yap',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
  }

  MaterialButton _registerButton(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      onPressed: () => _signUp(context),
      color: Colors.grey.shade100,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.signIn, size: 15, color: Colors.red),
          SizedBox(width: 5.0),
          Text(
            'Kaydol',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _inputField(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            labelText: 'T.C. Kimlik No',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            userId = value;
          },
        ),
        const SizedBox(height: 16.0),
        TextField(
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Şifre',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            password = value;
          },
        ),
      ],
    );
  }

  void _signIn(BuildContext context) {
    var authViewModel = context.read<AuthViewModel>();

    authViewModel.loginAsPatient(userId, password).then((patient) {
      if (patient != null) {
        context.go("/home");
      } else {
        displayErrorMessage(context, content: "Hatalı Giriş");
      }
    });
  }

  void _signUp(BuildContext context) {
    showBarModalBottomSheet(
        context: context,
        builder: (newContext) {
          return ChangeNotifierProvider(
            create: (context) => SignUpModalViewModel(),
            child: const SignUpModal(),
            builder: (context, child) {
              return child!;
            },
          );
        });
  }

}
