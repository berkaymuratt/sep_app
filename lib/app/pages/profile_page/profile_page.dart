import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sep_app/app/pages/profile_page/profile_page_view_model.dart';
import 'package:sep_app/app/shared/sep_app_scaffold/sep_app_scaffold.dart';
import 'package:sep_app/app/shared/sep_toast_messages.dart';
import 'package:sep_app/app/shared/view_models/auth_view_model.dart';
import 'package:sep_app/models/users/patient_model.dart';
import 'package:sep_app/models/users/user_info/patient_info_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController nameController;
  late TextEditingController surnameController;
  late TextEditingController genderController;
  late TextEditingController ageController;
  late TextEditingController heightController;
  late TextEditingController weightController;
  late TextEditingController telephoneController;
  late TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    PatientInfoModel patientInfo =
        context.read<AuthViewModel>().patientUser!.patientInfo!;

    final viewModel = context.watch<ProfilePageViewModel>();

    return SepAppScaffold(
      child: Stack(children: [
        ListView(
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _userIcon(),
              ],
            ),
            _inputs(patientInfo),
            _updateButton(context),
          ],
        ),
        viewModel.isStateLoading
            ? Container(
          color: Colors.black26,
          child: const Center(
              child: CircularProgressIndicator(color: Colors.white)),
        )
            : Container(),
      ]),
    );
  }

  Widget _inputs(PatientInfoModel patientInfo) {
    nameController = TextEditingController(text: patientInfo.name);
    surnameController = TextEditingController(text: patientInfo.surname);
    genderController = TextEditingController(text: patientInfo.gender);
    ageController = TextEditingController(text: patientInfo.age.toString());
    heightController =
        TextEditingController(text: patientInfo.height.toString());
    weightController =
        TextEditingController(text: patientInfo.weight.toString());
    telephoneController = TextEditingController(text: patientInfo.telephone);
    addressController = TextEditingController(text: patientInfo.address);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

  Widget _userIcon() {
    return Container(
      padding: const EdgeInsets.all(35),
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
      child: const FaIcon(
        FontAwesomeIcons.userLarge,
        color: Colors.red,
        size: 50,
      ),
    );
  }

  Widget _updateButton(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: MaterialButton(
            color: Colors.red,
            onPressed: () => _updateUserInfo(context),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.save,
                  color: Colors.white,
                ),
                SizedBox(width: 5),
                Text(
                  "Güncelle",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _updateUserInfo(BuildContext context) {
    final PatientModel user = context.read<AuthViewModel>().patientUser!;

    user.patientInfo = PatientInfoModel(
      name: nameController.text,
      surname: surnameController.text,
      telephone: telephoneController.text,
      address: addressController.text,
      gender: genderController.text,
      age: int.parse(ageController.text),
      height: int.parse(heightController.text),
      weight: double.parse(weightController.text),
    );

    context
        .read<ProfilePageViewModel>()
        .updatePatient(user)
        .then((isSuccessful) {
      if (isSuccessful) {
        displaySuccessMessage(context, content: "Başarıyla güncellendi");
      } else {
        displayErrorMessage(context, content: "Bir hata oluştu");
      }
    });
  }
}
