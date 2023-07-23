import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/home_controller.dart';

class AtmCard extends StatelessWidget {
  const AtmCard({
    super.key,
    required this.controller,
  });
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
          Scaffold(
            body: FutureBuilder(
              future: controller.getApiCard(),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        color: const Color.fromARGB(255, 57, 54, 54),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height,
                        color: Colors.blue[400],
                        child: Container(
                          child: Transform.rotate(
                            angle: 90 * (pi / 180),
                            child: Center(
                              child: Image.memory(
                                base64Decode(
                                  controller.atmCard.value,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
              },
            ),
            floatingActionButton: Container(
              width: 30,
              height: 30,
              color: Colors.red,
              child: FloatingActionButton(
                focusColor: Colors.red,
                backgroundColor: Colors.red,
                hoverColor: Colors.green,
                onPressed: () {
                  Get.back();
                },
                child: Container(
                  child: Icon(Icons.close),
                ),
              ),
            ),
          ),
          isScrollControlled: true,
          enableDrag: true,
          isDismissible: true,
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(1, 4.0),
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.grey.shade400,
              offset: Offset(0.5, 3.0),
              spreadRadius: 1,
              blurRadius: 2,
            ),
            BoxShadow(
              color: Colors.grey.shade400,
              offset: Offset(
                -1,
                0,
              ),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 115,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.50,
                    color: Colors.transparent,
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "1001538370697",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Mahmud",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "PT Ewindo",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 150,
                    color: Colors.transparent,
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          margin: EdgeInsets.all(20),
                          width: 60,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey,
                            image: DecorationImage(
                                image: AssetImage("assets/logo/mandiri.png"),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //============================= Tampilkan Card =============================
            Container(
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_card_outlined,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Tampilkan Card",
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
