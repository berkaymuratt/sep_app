import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sep_app/app/shared/modals/select_date_modal/select_date_modal_view_model.dart';
import 'package:sep_app/app/shared/sep_colors.dart';
import 'package:sep_app/app/shared/sep_date_formatter.dart';
import 'package:sep_app/app/shared/view_models/auth_view_model.dart';

class SelectDateModal extends StatefulWidget {
  final void Function(DateTime dateTime) onSave;

  const SelectDateModal({Key? key, required this.onSave}) : super(key: key);

  @override
  State<SelectDateModal> createState() => _SelectDateModalState();
}

class _SelectDateModalState extends State<SelectDateModal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SelectDateModalViewModel>();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 50 / 100,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          _header,
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              children: [
                _dateField(context),
                const SizedBox(height: 20),
                _timeDropdown(context),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _selectButton(context),
        ],
      ),
    );
  }

  Widget get _header {
    return Column(
      children: [
        Row(
          children: const [
            FaIcon(FontAwesomeIcons.calendar),
            SizedBox(width: 10),
            Text(
              "Tarih Seçme",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
        const Divider(thickness: 2),
      ],
    );
  }

  Widget _dateField(BuildContext context) {
    final viewModel = context.watch<SelectDateModalViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () => _displayDatePicker(context),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                style: BorderStyle.solid,
                color: Colors.grey,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: viewModel.selectedDate == null
                  ? const [
                      Text("Lütfen bir tarih seçiniz"),
                      SizedBox(width: 15),
                      FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                        size: 20,
                      ),
                    ]
                  : [
                      Text(
                        SepDateFormatter.dateFormatter
                            .format(viewModel.selectedDate!),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _timeDropdown(BuildContext context) {
    final viewModel = context.read<SelectDateModalViewModel>();

    String defaultText = "Lütfen bir saat seçiniz";

    if (viewModel.availableTimes == null) {
      defaultText = "Lütfen öncelikle bir tarih seçiniz";
    }

    if (viewModel.availableTimes != null && viewModel.availableTimes!.isEmpty) {
      defaultText = "Bu tarihte uygun bir saat bulunmuyor";
    }

    List<DropdownMenuItem<DateTime>> times = [
      DropdownMenuItem(
        value: null,
        child: Text(
          defaultText,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    ];

    if (viewModel.availableTimes != null) {
      for (var time in viewModel.availableTimes!) {
        times.add(DropdownMenuItem(
            value: time,
            child: Text(SepDateFormatter.timeFormatter.format(time))));
      }
    }

    return DropdownButtonFormField(
      value: viewModel.selectedDateWithTime,
      menuMaxHeight: 200,
      decoration: InputDecoration(
        labelText: 'Saat',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      items: times,
      validator: (selectedValue) {
        if (selectedValue == null) {
          return "Lütfen bir saat seçiniz";
        }
        return null;
      },
      onChanged: (date) {
        if (date != null) {
          viewModel.selectedDateWithTime = date;
        }
      },
    );
  }

  Widget _selectButton(BuildContext context) {
    final viewModel = context.read<SelectDateModalViewModel>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MaterialButton(
            color: SepColors.primaryColor,
            padding: const EdgeInsets.all(8.0),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.onSave(viewModel.selectedDateWithTime!);
                context.pop();
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                FaIcon(
                  FontAwesomeIcons.check,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: 5),
                Text(
                  "Seç",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _displayDatePicker(BuildContext context) {
    final viewModel = context.read<SelectDateModalViewModel>();

    showDatePicker(
      context: context,
      initialDate: viewModel.selectedDate == null
          ? DateTime.now()
          : viewModel.selectedDate!,
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    ).then((newDate) {
      viewModel.selectedDateWithTime = null;
      viewModel.selectedDate = newDate;
      if (newDate != null) {
        String doctorId = context.read<AuthViewModel>().patientUser!.doctorId;
        viewModel.getAvailableTimes(doctorId, newDate);
      } else {
        viewModel.clearAvailableTimes();
      }
    });
  }
}
