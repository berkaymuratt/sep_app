import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sep_app/app/pages/appointment_details_page/dart/appointment_details_page_view_model.dart';
import 'package:sep_app/app/pages/report_details_page/dart/report_details_page.dart';
import 'package:sep_app/app/pages/report_details_page/dart/report_details_page_view_model.dart';
import 'package:sep_app/app/shared/sep_colors.dart';
import 'package:sep_app/app/shared/sep_app_scaffold/sep_app_scaffold.dart';
import 'package:sep_app/app/shared/widgets/sep_divider/sep_divider.dart';
import 'package:sep_app/app/shared/widgets/sep_loader/sep_loader.dart';
import 'package:sep_app/models/symptom_model.dart';

class AppointmentDetailsPage extends StatefulWidget {
  final String appointmentId;

  const AppointmentDetailsPage({Key? key, required this.appointmentId})
      : super(key: key);

  @override
  State<AppointmentDetailsPage> createState() => _AppointmentDetailsPageState();
}

class _AppointmentDetailsPageState extends State<AppointmentDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<AppointmentDetailsPageViewModel>()
          .getAppointment(widget.appointmentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AppointmentDetailsPageViewModel>();

    if (viewModel.isStateLoading) {
      return const SepAppScaffold(
        child: Center(
          child: SepLoader(),
        ),
      );
    } else {
      var appointment = viewModel.appointment!;

      final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
      final DateFormat timeFormatter = DateFormat('HH:mm:ss');

      return SepAppScaffold(
        child: ListView(
          children: [
            const SizedBox(height: 5.0),
            _title,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _field("Tarih", dateFormatter.format(appointment.date!)),
                  _field("Saat", timeFormatter.format(appointment.date!)),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: SepDivider(height: 0.8, width: 500),
                  ),
                  _field("Doktor",
                      "${appointment.doctor!.doctorInfo!.name} ${appointment.doctor!.doctorInfo!.surname}"),
                  _field("Telefon", appointment.doctor!.doctorInfo!.telephone),
                  _field("Adres", appointment.doctor!.doctorInfo!.address),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: SepDivider(height: 0.8, width: 500),
                  ),
                  _field("Hasta",
                      "${appointment.patient!.patientInfo!.name} ${appointment.patient!.patientInfo!.surname}"),
                  _field("Cinsiyet", appointment.patient!.patientInfo!.gender),
                  _field("Yaş", appointment.patient!.patientInfo!.age.toString()),
                  _field("Boy", "${appointment.patient!.patientInfo!.height} cm"),
                  _field(
                      "Kilo", "${appointment.patient!.patientInfo!.weight} kg"),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: SepDivider(height: 0.8, width: 500),
                  ),
                  _field(
                      "Semptomlar", _symptomsAsString(appointment.symptoms!)),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: SepDivider(height: 0.8, width: 500),
                  ),
                  _field("Hastanın Notu", appointment.patientNote),
                  _displayReportButton(context, appointment.reportId),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  Padding get _title {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Randevu Detayları",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              fontFamily: "SignikaFont",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SepDivider(height: 1.5, width: 280),
        ],
      ),
    );
  }

  Widget _field(String field, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "$field:",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
            ),
          ),
        ],
      ),
    );
  }

  String _symptomsAsString(List<SymptomModel> symptomsList) {
    String s = "";

    for (var symptom in symptomsList) {
      s += "- ${symptom.name} (${symptom.level}. seviye)\n";
    }

    return s;
  }

  Widget _displayReportButton(BuildContext context, String reportId) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 25.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MaterialButton(
            onPressed: () {
              showBarModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ChangeNotifierProvider(
                      create: (context) => ReportDetailsPageViewModel(),
                      child: ReportDetailsPage(reportId: reportId, isPageView: false),
                      builder: (context, child) {
                        return child!;
                      },
                    );
                  });
            },
            color: SepColors.primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                FaIcon(
                  FontAwesomeIcons.fileCircleCheck,
                  color: Colors.white,
                  size: 20.0,
                ),
                SizedBox(width: 10),
                Text(
                  "Raporu Görüntüle",
                  style: TextStyle(
                    color: Colors.white,
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
