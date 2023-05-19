import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sep_app/app/pages/home_page/widgets/home_menu_card.dart';
import 'package:sep_app/app/shared/sep_app_scaffold/sep_app_scaffold.dart';

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
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*20/100,
                  width: 200,
                  child: Image.asset("assets/images/heart.png"),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Divider(thickness: 3),
                ),
              ],
            ),
          ),
          _menu(context),
        ],
      ),
    );
  }

  Widget _menu(BuildContext context) {
    return Flexible(
      child: Container(
        height: MediaQuery.of(context).size.height * 60 / 100,
        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3),
        child: _buttons(context),
      ),
    );
  }

  Widget _buttons(BuildContext context) {
    return GridView.count(
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
          onPressed: () {
            context.go("/home/create-appointment");
          },
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
    );
  }
}
