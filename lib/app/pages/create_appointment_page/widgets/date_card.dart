import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sep_app/app/pages/create_appointment_page/create_appointment_page_view_model.dart';
import 'package:sep_app/app/shared/modals/select_date_modal/select_date_modal.dart';
import 'package:sep_app/app/shared/modals/select_date_modal/select_date_modal_view_model.dart';
import 'package:sep_app/app/shared/sep_colors.dart';
import 'package:sep_app/app/shared/sep_date_formatter.dart';

class DateCard extends StatelessWidget {
  const DateCard({Key? key}) : super(key: key);

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
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          _header(context),
          const Divider(thickness: 2, height: 25),
          const SizedBox(height: 15),
          _displayedDate(context),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            FaIcon(
              FontAwesomeIcons.calendarDays,
              color: SepColors.primaryColor,
            ),
            const SizedBox(width: 8.0),
            Text(
              "Tarih Seçimi",
              style: TextStyle(
                color: SepColors.primaryColor,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            showBarModalBottomSheet(
                context: context,
                builder: (newContext) {
                  return ChangeNotifierProvider(
                    create: (context) => SelectDateModalViewModel(),
                    child: SelectDateModal(
                      onSave: (selectedDate) {
                        context
                            .read<CreateAppointmentPageViewModel>()
                            .selectedDate = selectedDate;
                      },
                    ),
                    builder: (context, child) {
                      return child!;
                    },
                  );
                });
          },
          child: FaIcon(
            FontAwesomeIcons.magnifyingGlass,
            color: SepColors.primaryColor,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _displayedDate(BuildContext context) {
    final viewModel = context.watch<CreateAppointmentPageViewModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          viewModel.selectedDate != null
              ? SepDateFormatter.dateFormatter.format(viewModel.selectedDate!)
              : "Lütfen bir tarih seçiniz",
          style: const TextStyle(
            // color: Colors.white,
            fontSize: 17,
          ),
        ),
        Text(
          viewModel.selectedDate != null
              ? SepDateFormatter.timeFormatter.format(viewModel.selectedDate!)
              : "",
          style: const TextStyle(
            // color: Colors.white,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
