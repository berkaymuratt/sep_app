import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sep_app/app/pages/report_details_page/dart/report_details_page_view_model.dart';
import 'package:sep_app/app/shared/widgets/sep_app_scaffold/sep_app_scaffold.dart';
import 'package:sep_app/app/shared/widgets/sep_loader/sep_loader.dart';

class ReportDetailsPage extends StatefulWidget {
  final String reportId;
  final bool isPageView;

  const ReportDetailsPage({Key? key, required this.reportId, this.isPageView = true}) : super(key: key);

  @override
  State<ReportDetailsPage> createState() => _ReportDetailsPageState();
}

class _ReportDetailsPageState extends State<ReportDetailsPage> {
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
            height: MediaQuery.of(context).size.height * 85 / 100,
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
            height: MediaQuery.of(context).size.height * 85 / 100,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child:
            // TODO: Aşağıdaki Center widget ı yerine sayfa oluşturulabilir
            // TODO: Rapor bilgileri report değişkeninde tutuluyor
            Center(
              child: Text(report.id),
            ),
          ),
      );
    }
  }

  Widget _build(Widget child) {
    if (widget.isPageView) {
      return SepAppScaffold(child: child);
    } else {
      return child;
    }
  }
}
