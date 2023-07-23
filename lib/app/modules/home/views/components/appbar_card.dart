// import 'package:fit_aja_final/app/modules/home/views/container_home/widgets/atm_card.dart';
import 'package:flutter/material.dart';
import '../../controllers/home_controller.dart';
import '../widgets/app_bar_home.dart';
import '../widgets/atm_card.dart';
// import 'widgets/app_bar_home.dart';

class AppBarCard extends StatelessWidget {
  const AppBarCard({
    required this.controller,
    super.key,
  });
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(bottom: 10),
          height: 250,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
        Container(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.17,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 42, 139, 218),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        //AppBar and Card
        Column(
          children: [
            AppBarFit(controller: controller),
            AtmCard(controller: controller),
          ],
        ),
      ],
    );
  }
}
