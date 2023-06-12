import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sep_app/app/pages/appointment_details_page/dart/widgets/info_card.dart';
import 'package:sep_app/app/pages/report_details_page/dart/report_details_page_view_model.dart';
import 'package:sep_app/app/shared/sep_app_scaffold/sep_app_scaffold.dart';
import 'package:sep_app/app/shared/widgets/sep_divider/sep_divider.dart';
import 'package:sep_app/app/shared/widgets/sep_loader/sep_loader.dart';
import 'package:sep_app/models/disease_model.dart';
import 'package:sep_app/models/report_model.dart';
import 'package:sep_app/models/symptom_model.dart';

class ReportDetailsPage extends StatefulWidget {
  final String reportId;
  final bool isPageView;

  const ReportDetailsPage({Key? key, required this.reportId, this.isPageView = true}) : super(key: key);

  @override
  State<ReportDetailsPage> createState() => _ReportDetailsPageState();
}

class _ReportDetailsPageState extends State<ReportDetailsPage> {

  final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
  final DateFormat timeFormatter = DateFormat('HH:mm');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReportDetailsPageViewModel>().getReport(widget.reportId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ReportDetailsPageViewModel>();

    if (viewModel.isStateLoading) {
      return _build(
        Container(
          height: !widget.isPageView ? MediaQuery.of(context).size.height * 85 / 100 : null,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: const Center(
            child: SepLoader(),
          ),
        ),
      );
    } else {
      var report = viewModel.report!;

      return _build(
        Container(
            height: !widget.isPageView ? MediaQuery.of(context).size.height * 85 / 100 : null,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: _body(report)
        ),
      );
    }
  }

  Widget _body(ReportModel report) {
    return ListView(
      children: [
        const SizedBox(height: 5.0),
        _title,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: _cards(report),
          ),
        ),
      ],
    );
  }

  List<Widget> _cards(ReportModel report) {
    return [
      _patientInfoCard(report),
      _doctorInfoCard(report),
      _timeInfoCard(report),
      _symptomInfoCard(report),
      _diseasesInfoCard(report),
      _patientNoteCard(report),
      report.doctorFeedback.isNotEmpty ? _doctorFeedback(report) : Container(),
      const SizedBox(height: 15.0),
    ];
  }

  InfoCard _doctorFeedback(ReportModel report) {
    return InfoCard(
      title: "Doktorun Yorumu",
      icon: FontAwesomeIcons.userDoctor,
      items: [
        InfoCardItem(name: "Yorum", value: report.doctorFeedback)
      ],
    );
  }

  InfoCard _patientNoteCard(ReportModel report) {
    return InfoCard(
      title: "Hastanın Notu",
      icon: FontAwesomeIcons.notesMedical,
      items: [
        InfoCardItem(name: "Not", value: report.patientNote)
      ],
    );
  }

  InfoCard _diseasesInfoCard(ReportModel report) {
    return InfoCard(
      title: "Olası Hastalıklar",
      icon: FontAwesomeIcons.disease,
      items: _diseasesAsInfoCardItems(report.possibleDiseases),
    );
  }

  InfoCard _symptomInfoCard(ReportModel report) {
    return InfoCard(
      title: "Semptom Bilgisi",
      icon: FontAwesomeIcons.bedPulse,
      items: _symptomsAsInfoCardItems(report.symptoms),
    );
  }

  InfoCard _timeInfoCard(ReportModel report) {
    return InfoCard(
      title: "Zaman Bilgisi",
      icon: FontAwesomeIcons.clock,
      items: [
        InfoCardItem(
            name: "Oluşturulduğu Tarih",
            value: dateFormatter.format(report.createdAt)),
        InfoCardItem(
            name: "Oluşturulduğu Saat",
            value: timeFormatter.format(report.createdAt)),
      ],
    );
  }

  InfoCard _doctorInfoCard(ReportModel report) {
    return InfoCard(
      title: "Doktor Bilgisi",
      icon: FontAwesomeIcons.userDoctor,
      items: [
        InfoCardItem(
            name: "Doktor",
            value:
            "${report.doctor.doctorInfo!.name} ${report.doctor.doctorInfo!.surname}"),
        InfoCardItem(
            name: "Telefon",
            value: report.doctor.doctorInfo!.telephone),
        InfoCardItem(
            name: "Adres",
            value: report.doctor.doctorInfo!.address),
      ],
    );
  }

  InfoCard _patientInfoCard(ReportModel report) {
    return InfoCard(
      title: "Hasta Bilgisi",
      icon: FontAwesomeIcons.hospitalUser,
      items: [
        InfoCardItem(
            name: "Hasta",
            value:
            "${report.patient.patientInfo!.name} ${report.patient.patientInfo!.surname}"),
        InfoCardItem(
            name: "Cinsiyet",
            value: report.patient.patientInfo!.gender),
        InfoCardItem(
            name: "Yaş",
            value:
            report.patient.patientInfo!.age.toString()),
        InfoCardItem(
            name: "Boy",
            value:
            "${report.patient.patientInfo!.height} cm"),
        InfoCardItem(
            name: "Kilo",
            value:
            "${report.patient.patientInfo!.weight} kg"),
      ],
    );
  }

  List<InfoCardItem> _symptomsAsInfoCardItems(List<SymptomModel> symptomsList) {
    List<InfoCardItem> symptoms = [];

    for (int i = 0; i < symptomsList.length; i++) {
      var symptom = symptomsList[i];
      symptoms.add(InfoCardItem(
          name: "Semptom ${i + 1}",
          value: "${symptom.name} (${symptom.level}. seviye)\n"));
    }

    return symptoms;
  }

  List<InfoCardItem> _diseasesAsInfoCardItems(List<DiseaseModel> diseasesList) {
    List<InfoCardItem> diseases = [];

    for (int i = 0; i < diseasesList.length; i++) {
      var disease = diseasesList[i];
      diseases.add(InfoCardItem(
          name: "Olası Hastalık ${i + 1}",
          value: disease.name));
    }

    if (diseases.isEmpty) {
      diseases.add(InfoCardItem(name: "Olası Hastalık", value: "Yok"));
    }

    return diseases;
  }

  Padding get _title {
    return const Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FaIcon(FontAwesomeIcons.calendarDays, size: 15),
              SizedBox(width: 10),
              Text(
                "Rapor Detayları",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: "SignikaFont",
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SepDivider(height: 1.5, width: 280),
        ],
      ),
    );
  }

  Widget _build(Widget child) {
    if (widget.isPageView) {
      return SepAppScaffold(child: child);
    } else {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: child,
      );
    }
  }
}