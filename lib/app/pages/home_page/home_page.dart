import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sep_app/app/pages/home_page/widgets/home_menu_card.dart';
import 'package:sep_app/app/shared/widgets/sep_app_scaffold/sep_app_scaffold.dart';
import 'package:sep_app/app/shared/widgets/sep_divider/sep_divider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SepAppScaffold(
      isDrawerActive: true,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: SizedBox(
              height: 150,
              width: 200,
              child: Image.asset("assets/images/heart.png"),
            ),
          ),
          _menu(context),
          const SepDivider(
            height: 1,
            width: 330,
          ),
        ],
      ),
    );
  }

  Widget _menu(BuildContext context) {
    return Container(
      height: 500,
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        children: [
          HomeMenuCard(
            title: "Randevularım",
            onPressed: () {
              context.go("/home/my-appointments");
            },
            iconData: FontAwesomeIcons.calendarDay,
            iconColor: Colors.blue,
          ),
          HomeMenuCard(
            title: "Randevu Al",
            onPressed: () {},
            iconData: Icons.add,
            iconColor: Colors.green,
          ),
          HomeMenuCard(
            title: "Raporlarım",
            onPressed: () {
              context.go("/home/my-reports");
            },
            iconData: FontAwesomeIcons.fileLines,
            iconColor: Colors.purple,
          ),
          HomeMenuCard(
            title: "Doktorum",
            onPressed: () {
              context.go("/home/doctor-info");
            },
            iconData: FontAwesomeIcons.userDoctor,
          ),
        ],
      ),
    );
  }
}
