import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sep_app/app/shared/modals/sign_up_modal/sign_up_modal_view_model.dart';
import 'package:sep_app/app/shared/sep_colors.dart';

class SignUpModal extends StatefulWidget {
  const SignUpModal({Key? key}) : super(key: key);

  @override
  State<SignUpModal> createState() => _SignUpModalState();
}

class _SignUpModalState extends State<SignUpModal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SignUpModalViewModel>();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 85 / 100,
      child: Stack(
        children: [
          _body(context),
          viewModel.isStateLoading
              ? Container(
                  color: Colors.black26,
                  child: const Center(
                      child: CircularProgressIndicator(color: Colors.white)),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView(
        children: [
          _header,
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              children: [
                _inputs(),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _signUpButton(context),
        ],
      ),
    );
  }

  Widget get _header {
    return const Column(
      children: [
        Row(
          children: [
            FaIcon(FontAwesomeIcons.userPlus, color: Colors.redAccent),
            SizedBox(width: 10),
            Text(
              "Kayıt Ol",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
        Divider(thickness: 2),
      ],
    );
  }

  Widget _inputs() {
    TextEditingController userIdController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController surnameController = TextEditingController();
    TextEditingController genderController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController heightController = TextEditingController();
    TextEditingController weightController = TextEditingController();
    TextEditingController telephoneController = TextEditingController();
    TextEditingController addressController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kullanıcı Giriş Bilgileri',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'T.C Numarası',
              border: OutlineInputBorder(),
            ),
            controller: userIdController,
            readOnly: true,
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Şifre',
              border: OutlineInputBorder(),
            ),
            controller: passwordController,
            readOnly: true,
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Şifre Onay',
              border: OutlineInputBorder(),
            ),
            controller: confirmPasswordController,
            readOnly: true,
          ),
          const SizedBox(height: 30),
          const Text(
            'Hasta Bilgileri',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          TextField(
            decoration: const InputDecoration(
              labelText: 'İsim',
              border: OutlineInputBorder(),
            ),
            controller: nameController,
            readOnly: true,
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Soyisim',
              border: OutlineInputBorder(),
            ),
            controller: surnameController,
            readOnly: true,
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Cinsiyet',
              border: OutlineInputBorder(),
            ),
            controller: genderController,
            readOnly: true,
          ),
          const SizedBox(height: 10),
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Yaş',
              border: OutlineInputBorder(),
            ),
            controller: ageController,
          ),
          const SizedBox(height: 10),
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Boy',
              border: OutlineInputBorder(),
            ),
            controller: heightController,
          ),
          const SizedBox(height: 10),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Kilo',
              border: OutlineInputBorder(),
            ),
            controller: weightController,
          ),
          const SizedBox(height: 30),
          const Text(
            'İletişim Bilgileri',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Telefon',
              border: OutlineInputBorder(),
            ),
            controller: telephoneController,
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Adres',
              border: OutlineInputBorder(),
            ),
            controller: addressController,
          ),
        ],
      ),
    );
  }

  Widget _signUpButton(BuildContext context) {
    final viewModel = context.read<SignUpModalViewModel>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MaterialButton(
            color: SepColors.primaryColor,
            padding: const EdgeInsets.all(8.0),
            onPressed: () {},
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.signIn,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: 5),
                Text(
                  "Kayıt Ol",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
