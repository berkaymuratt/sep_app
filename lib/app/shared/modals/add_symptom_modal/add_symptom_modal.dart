import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sep_app/app/shared/modals/add_symptom_modal/add_symptom_modal_view_model.dart';
import 'package:sep_app/app/shared/sep_colors.dart';
import 'package:sep_app/models/body_part_model.dart';
import 'package:sep_app/models/symptom_model.dart';

class AddSymptomModal extends StatefulWidget {
  final void Function(SymptomModel symptom) onSave;

  const AddSymptomModal({Key? key, required this.onSave}) : super(key: key);

  @override
  State<AddSymptomModal> createState() => _AddSymptomModalState();
}

class _AddSymptomModalState extends State<AddSymptomModal> {
  final GlobalKey<FormState> _dropdownsKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddSymptomModalViewModel>().getBodyParts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddSymptomModalViewModel>();

    return Theme(
      data: ThemeData(
        primaryColor: Colors.blue,
        primarySwatch: Colors.green,
      ),
      child: SizedBox(
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
            key: _dropdownsKey,
            child: Column(
              children: [
                _bodyPartsDropdown(context),
                const SizedBox(height: 20),
                _symptomsDropdown(context),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _addButton(context),
        ],
      ),
    );
  }

  Widget get _header {
    return Column(
      children: [
        Row(
          children: const [
            FaIcon(FontAwesomeIcons.circlePlus),
            SizedBox(width: 10),
            Text(
              "Semptom Ekleme",
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

  Widget _bodyPartsDropdown(BuildContext context) {
    final viewModel = context.read<AddSymptomModalViewModel>();

    List<DropdownMenuItem<BodyPartModel?>> items = [
      DropdownMenuItem(
          value: null,
          child: Text(
            "Vücut bölgenizi seçiniz",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          )),
    ];

    if (viewModel.bodyParts != null) {
      for (BodyPartModel bodyPart in viewModel.bodyParts!) {
        items.add(DropdownMenuItem(
          value: bodyPart,
          child: Text(bodyPart.name),
        ));
      }
    }

    return DropdownButtonFormField<BodyPartModel?>(
      menuMaxHeight: 200,
      decoration: InputDecoration(
        labelText: 'Vücut Bölgesi',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      items: items,
      validator: (selectedValue) {
        if (selectedValue == null) {
          return "Lütfen bir vücut bölgesi seçiniz";
        }
        return null;
      },
      onChanged: (bodyPart) {
        viewModel.clearSymptoms();

        if (bodyPart != null) {
          viewModel.getSymptoms(bodyPart.id);
        }
      },
    );
  }

  Widget _symptomsDropdown(BuildContext context) {
    final viewModel = context.watch<AddSymptomModalViewModel>();

    List<DropdownMenuItem<SymptomModel>> items = [
      DropdownMenuItem(
          value: null,
          child: Text(
            "Semptom seçiniz",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          )),
    ];

    if (viewModel.symptoms != null) {
      for (SymptomModel symptom in viewModel.symptoms!) {
        items.add(DropdownMenuItem(
          value: symptom,
          child: Text("${symptom.name} ${symptom.level}.Seviye"),
        ));
      }
    }

    return DropdownButtonFormField<SymptomModel>(
      value: viewModel.selectedSymptom,
      menuMaxHeight: 200,
      decoration: InputDecoration(
        labelText: 'Semptom',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      items: items,
      validator: (selectedValue) {
        if (selectedValue == null) {
          return "Lütfen bir semptom seçiniz";
        }
        return null;
      },
      onChanged: (symptom) {
        if (symptom != null) {
          viewModel.selectedSymptom = symptom;
        }
      },
    );
  }

  Widget _addButton(BuildContext context) {
    final viewModel = context.read<AddSymptomModalViewModel>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MaterialButton(
            color: SepColors.primaryColor,
            padding: const EdgeInsets.all(8.0),
            onPressed: () {
              if (_dropdownsKey.currentState!.validate()) {
                widget.onSave(viewModel.selectedSymptom!);
                context.pop();
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                FaIcon(
                  FontAwesomeIcons.plus,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: 5),
                Text(
                  "Ekle",
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
}
