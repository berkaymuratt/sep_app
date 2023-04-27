import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sep_app/app/shared/sep_colors.dart';
import 'package:sep_app/models/report_model.dart';

class ReportCard extends StatelessWidget {
  final ReportModel report;
  final int number;

  const ReportCard({Key? key, required this.report, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd HH:mm');

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        leading: FaIcon(
          FontAwesomeIcons.fileLines,
          color: SepColors.primaryColor,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Report $number",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              "Oluşturulma Tarihi: ${dateFormatter.format(report.createdAt)}",
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 14.5,
              ),
            ),
          ],
        ),
        trailing: FaIcon(
          Icons.arrow_forward_ios,
          color: SepColors.primaryColor,
        ),
        onTap: () {
          context.go("/home/my-reports/${report.id}");
        },
      ),
    );
  }
}
