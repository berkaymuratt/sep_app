import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sep_app/app/shared/sep_colors.dart';
import 'package:sep_app/app/shared/sep_date_formatter.dart';
import 'package:sep_app/models/appointment_model.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;

  const AppointmentCard({Key? key, required this.appointment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        leading: FaIcon(
          FontAwesomeIcons.calendarDays,
          color: SepColors.primaryColor,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              SepDateFormatter.dateFormatter.format(appointment.date!),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _isAppointmentToday(appointment.date!) ? Colors.green : null,
                fontSize: 17.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              SepDateFormatter.timeFormatter.format(appointment.date!),
              textAlign: TextAlign.end,
              style: TextStyle(
                color: _isAppointmentToday(appointment.date!) ? Colors.green : null,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        trailing: FaIcon(
          Icons.arrow_forward_ios,
          color: SepColors.primaryColor,
        ),
        onTap: () {
          context.go("/home/my-appointments/${appointment.id}");
        },
      ),
    );
  }

  bool _isAppointmentToday(DateTime date) {
    final now = DateTime.now();

    return now.day == date.day && now.month == date.month && date.year == date.year;
  }
}
