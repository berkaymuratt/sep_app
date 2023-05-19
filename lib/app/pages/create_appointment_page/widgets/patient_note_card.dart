import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sep_app/app/pages/create_appointment_page/create_appointment_page_view_model.dart';

class PatientNoteCard extends StatelessWidget {
  final TextEditingController controller;
  const PatientNoteCard({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CreateAppointmentPageViewModel>();

    if (viewModel.patientNote.isNotEmpty) {
      controller.text = viewModel.patientNote;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        controller: controller,
        maxLength: 500,
        maxLines: null,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: "Açıklamanızı buraya ekleyiniz",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}
