import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sep_app/app/pages/create_appointment_page/create_appointment_page_view_model.dart';
import 'package:sep_app/app/shared/modals/add_symptom_modal/add_symptom_modal.dart';
import 'package:sep_app/app/shared/modals/add_symptom_modal/add_symptom_modal_view_model.dart';
import 'package:sep_app/app/shared/sep_colors.dart';
import 'package:sep_app/models/symptom_model.dart';

class SymptomsCard extends StatelessWidget {
  const SymptomsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          style: BorderStyle.solid,
          color: Colors.white,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: SepColors.primaryColor,
      ),
      child: Column(
        children: [
          _header(context),
          const Divider(color: Colors.white, thickness: 2, height: 25),
          const SizedBox(height: 10),
          _symptomsList(context),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Semptomlar",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () {
            showBarModalBottomSheet(
                context: context,
                builder: (newContext) {
                  return ChangeNotifierProvider(
                    create: (context) => AddSymptomModalViewModel(),
                    child: AddSymptomModal(
                      onSave: (newSymptom) {
                        context
                            .read<CreateAppointmentPageViewModel>()
                            .addSelectedSymptom(newSymptom);
                      },
                    ),
                    builder: (context, child) {
                      return child!;
                    },
                  );
                });
          },
          child: const FaIcon(
            FontAwesomeIcons.plus,
            color: Colors.white,
            size: 22,
          ),
        )
      ],
    );
  }

  Widget _symptomsList(BuildContext context) {
    final viewModel = context.watch<CreateAppointmentPageViewModel>();

    List<Widget> symptoms = [];

    for (var symptom in viewModel.selectedSymptoms) {
      symptoms.add(
        _symptomAsCard(context, symptom),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: symptoms.isNotEmpty
          ? symptoms
          : const [
              Text(
                "Lütfen semptom ekleyiniz.",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
    );
  }

  Widget _symptomAsCard(BuildContext context, SymptomModel symptom) {
    return Card(
      child: ListTile(
        minVerticalPadding: 2,
        title: Text(
          "${symptom.name} - ${symptom.level}.Seviye",
        ),
        leading: FaIcon(
          FontAwesomeIcons.bedPulse,
          color: SepColors.primaryColor,
        ),
        subtitle: Text("Vücut Bölgesi: ${symptom.bodyPart.name}"),
        trailing: GestureDetector(
          onTap: () {
            context
                .read<CreateAppointmentPageViewModel>()
                .removeSelectedSymptom(symptom);
          },
          child: FaIcon(
            FontAwesomeIcons.circleMinus,
            color: SepColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
