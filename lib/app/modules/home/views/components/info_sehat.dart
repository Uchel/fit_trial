import 'dart:convert';

import 'package:fit_aja2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../webview.dart';
import '../../controllers/home_controller.dart';

class InfoSehatContainer extends StatelessWidget {
  const InfoSehatContainer({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 230,
      color: Colors.white,
      margin: EdgeInsets.only(top: 20, bottom: 20),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Info Sehat"),
                GestureDetector(
                  child: Text(
                    "Lihat Semua",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(Routes.INFO_SEHAT);
                  },
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 190,
            color: Colors.white,
            child: FutureBuilder(
              future: controller.getApiContent(),
              builder: (context, snapshot) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.contentInfoSehat.length > 5
                      ? controller.contentInfoSehat.take(5).length
                      : controller.contentInfoSehat.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => WebViewPage(
                              url: controller
                                  .contentInfoSehat[index].webContentUrl
                                  .toString(),
                              namaPage: controller
                                  .contentInfoSehat[index].webContentTitle
                                  .toString(),
                            ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 120,
                              height: 100,
                              child: Image.memory(
                                base64Decode(controller
                                    .contentInfoSehat[index].webContentImage
                                    .toString()),
                                fit: BoxFit.fitWidth,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              margin: EdgeInsets.only(
                                top: 10,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 120,
                              child: Text(
                                controller
                                    .contentInfoSehat[index].webContentTitle
                                    .toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 120,
                              child: Text(
                                controller
                                    .contentInfoSehat[index].webContentDate
                                    .toString(),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
