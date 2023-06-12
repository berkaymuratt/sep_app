import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sep_app/app/shared/widgets/sep_divider/sep_divider.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<InfoCardItem> items;

  const InfoCard({Key? key, required this.title, required this.icon, required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: _decoration,
      child: Column(
        children: [
          Row(
            children: [
              FaIcon(
                icon,
                size: 18,
                color: Colors.red,
              ),
              Text(
                " $title",
                style: const TextStyle(
                  // color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: SepDivider(width: 180, height: 2, color: Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            children: _fields,
          ),
        ],
      ),
    );
  }

  List<Widget> get _fields {
    List<Widget> fields = [];

    for (var infoCard in items) {
      fields.add(
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "${infoCard.name}:",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    // color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  infoCard.value,
                  style: const TextStyle(
                    fontSize: 13
                      // color: Colors.white,
                      ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return fields;
  }

  BoxDecoration get _decoration {
    return BoxDecoration(
        color: Colors.white,
        border: Border.all(
          style: BorderStyle.solid,
          width: 2,
          color: Colors.grey,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black54.withOpacity(0.4),
            spreadRadius: 0.4,
            blurRadius: 6,
            offset: const Offset(0, 5), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(10));
  }
}

class InfoCardItem {
  final String name;
  final String value;

  InfoCardItem({required this.name, required this.value});
}
