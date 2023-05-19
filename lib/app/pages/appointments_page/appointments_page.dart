import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sep_app/app/pages/appointments_page/appointments_page_view_model.dart';
import 'package:sep_app/app/pages/appointments_page/widgets/appointment_card.dart';
import 'package:sep_app/app/shared/view_models/auth_view_model.dart';
import 'package:sep_app/app/shared/sep_app_scaffold/sep_app_scaffold.dart';
import 'package:sep_app/app/shared/widgets/sep_loader/sep_loader.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({Key? key}) : super(key: key);

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var currentPatient = context.read<AuthViewModel>().patientUser!;
      context
          .read<AppointmentsPageViewModel>()
          .getAppointments(currentPatient.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppointmentsPageViewModel viewModel = context.watch<AppointmentsPageViewModel>();

    return SepAppScaffold(
      child:  viewModel.isStateLoading ? const Center(child: SepLoader()) : ListView.builder(
        itemCount: viewModel.appointments!.length,
        itemBuilder: (context, index) {
          var appointment = viewModel.appointments![index];
          return AppointmentCard(appointment: appointment);
        },
      ),
    );
  }
}
