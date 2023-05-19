import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sep_app/app/pages/doctor_info_page/doctor_info_page_view_model.dart';
import 'package:sep_app/app/pages/doctor_info_page/widgets/doctor_info_card.dart';
import 'package:sep_app/app/shared/view_models/auth_view_model.dart';
import 'package:sep_app/app/shared/sep_app_scaffold/sep_app_scaffold.dart';
import 'package:sep_app/app/shared/widgets/sep_loader/sep_loader.dart';

class DoctorInfoPage extends StatefulWidget {
  const DoctorInfoPage({Key? key}) : super(key: key);

  @override
  State<DoctorInfoPage> createState() => _DoctorInfoPageState();
}

class _DoctorInfoPageState extends State<DoctorInfoPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var currentPatient = context.read<AuthViewModel>().patientUser!;
      context
          .read<DoctorInfoPageViewModel>()
          .getDoctor(currentPatient.doctorId);
    });
  }

  @override
  Widget build(BuildContext context) {
    var doctorInfoPageViewModel = context.watch<DoctorInfoPageViewModel>();

    return SepAppScaffold(
      child: doctorInfoPageViewModel.isStateLoading
          ? const Center(child: SepLoader())
          : DoctorInfoCard(doctor: doctorInfoPageViewModel.doctor!),
    );
  }
}
