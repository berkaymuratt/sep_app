import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sep_app/app/pages/reports_page/reports_page_view_model.dart';
import 'package:sep_app/app/pages/reports_page/widgets/report_card.dart';
import 'package:sep_app/app/shared/view_models/auth_view_model.dart';
import 'package:sep_app/app/shared/widgets/sep_app_scaffold/sep_app_scaffold.dart';
import 'package:sep_app/app/shared/widgets/sep_loader/sep_loader.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var currentPatient = context.read<AuthViewModel>().patientUser!;
      context
          .read<ReportsPageViewModel>()
          .getReportsByPatientId(currentPatient.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ReportsPageViewModel>();

    if (viewModel.isStateLoading) {
      return const SepAppScaffold(
        child: Center(
          child: SepLoader(),
        ),
      );
    } else {
      return SepAppScaffold(
        child: ListView.builder(
          itemCount: viewModel.reports!.length,
          itemBuilder: (context, index) {
            var report = viewModel.reports![index];
            return ReportCard(report: report, number: index + 1);
          },
        ),
      );
    }
  }
}
