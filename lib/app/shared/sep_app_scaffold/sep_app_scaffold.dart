import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sep_app/app/shared/sep_colors.dart';
import 'package:sep_app/app/shared/sep_app_scaffold/drawer_link.dart';
import 'package:sep_app/app/shared/view_models/auth_view_model.dart';

class SepAppScaffold extends StatelessWidget {
  final Widget child;
  final bool isDrawerActive;

  const SepAppScaffold({
    Key? key,
    required this.child,
    this.isDrawerActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: isDrawerActive ? Drawer(child: _drawerContent(context)) : null,
      appBar: AppBar(
        title: _title,
        centerTitle: true,
      ),
      backgroundColor: SepColors.backgroundColor,
      body: child,
    );
  }

  Widget get _title {
    return const Text(
      "SEP",
      style: TextStyle(
        fontFamily: 'SoftFont',
        fontSize: 23,
      ),
    );
  }

  Widget _drawerContent(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _profileSection(context),
          _menuSection(context),
        ],
      ),
    );
  }
}

Widget _profileSection(BuildContext context) {
  final viewModel = context.read<AuthViewModel>();
  final user = viewModel.patientUser!;

  return GestureDetector(
    onTap: () {
      context.go("/home/profile");
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      padding: const EdgeInsets.all(5.0),
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: Colors.grey,
        ),
      )),
      child: Row(
        children: [
          Icon(
            Icons.account_circle,
            color: SepColors.primaryColor,
            size: 50,
          ),
          const SizedBox(width: 10),
          Text(
            "${user.patientInfo!.name} ${user.patientInfo!.surname}",
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _menuSection(BuildContext context) {
  return SafeArea(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DrawerLink(
            title: "Sıkça Sorulan Sorular",
            prefixIcon: Icons.question_mark_sharp,
            path: "/home/faq"),
        DrawerLink(
            title: "Çıkış Yap", prefixIcon: Icons.logout, path: "/login", onPressed: () {
              context.read<AuthViewModel>().signOut();
        }),
      ],
    ),
  );
}
