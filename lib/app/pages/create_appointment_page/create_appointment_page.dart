import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sep_app/app/pages/create_appointment_page/create_appointment_page_view_model.dart';
import 'package:sep_app/app/pages/create_appointment_page/widgets/date_card.dart';
import 'package:sep_app/app/pages/create_appointment_page/widgets/patient_note_card.dart';
import 'package:sep_app/app/pages/create_appointment_page/widgets/symptoms_card.dart';
import 'package:sep_app/app/shared/sep_app_scaffold/sep_app_scaffold.dart';
import 'package:sep_app/app/shared/sep_toast_messages.dart';
import 'package:sep_app/app/shared/view_models/auth_view_model.dart';

class CreateAppointmentPage extends StatelessWidget {
  CreateAppointmentPage({Key? key}) : super(key: key);

  final TextEditingController patientNoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CreateAppointmentPageViewModel>();

    return SepAppScaffold(
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
    return ListView(
      children: [
        const DateCard(),
        const SymptomsCard(),
        PatientNoteCard(controller: patientNoteController),
        _createAppointmentButton(context),
      ],
    );
  }

  Widget _createAppointmentButton(BuildContext context) {
    final viewModel = context.watch<CreateAppointmentPageViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: MaterialButton(
        onPressed: viewModel.selectedDate != null &&
                viewModel.selectedSymptoms.isNotEmpty
            ? () => _createAppointment(context)
            : null,
        disabledColor: Colors.grey,
        color: Colors.red,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.calendarPlus,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text(
                "Randevuyu Oluştur",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createAppointment(BuildContext context) {
    final viewModel = context.read<CreateAppointmentPageViewModel>();
    viewModel.patientNote = patientNoteController.value.text;

    final authViewModel = context.read<AuthViewModel>();
    String patientId = authViewModel.patientUser!.id;
    String doctorId = authViewModel.patientUser!.doctorId;

    viewModel.createAppointment(patientId, doctorId).then((isSuccessful) {
      if (isSuccessful) {
        context.pop();
        displaySuccessMessage(context, content: "Randevunuz başarıyla oluşturulmuştur.");
      } else {
        displayErrorMessage(context, content: viewModel.errorMsg);
      }
    });
  }
}
