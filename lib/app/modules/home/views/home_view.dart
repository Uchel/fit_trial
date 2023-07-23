import 'package:fit_aja2/app/modules/home/views/components/info_sehat.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'components/appbar_card.dart';
import 'components/news2.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  // TODO: implement controller
  HomeController get controller => super.controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[400],
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            AppBarCard(controller: controller),
            InfoSehatContainer(controller: controller),
            NewsContainer2(controller: controller),
          ],
        ),
      ),
    );
  }
}
