// import 'dart:convert';

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../controllers/home_controller.dart';
import '../webview.dart';

class NewsContainer2 extends StatelessWidget {
  const NewsContainer2({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 270,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          margin: EdgeInsets.only(bottom: 10, top: 10),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          height: 260,
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              news_lihatsemua(context),
              view_list_view(),
              SizedBox(
                height: 20,
              ),
              indicator(),
            ],
          ),
        ),
      ],
    );
  }

  MemoryImage base64News(int index) {
    try {
      String base64Image =
          controller.contentNews[index].webContentImage.toString();
      Uint8List imageBytes = base64Decode(base64Image);
      return MemoryImage(imageBytes);
    } catch (e) {
      print("Kesalahan saat mendekodekan data Base64: $e");

      String base64Image =
          controller.contentInfoSehat[0].webContentImage.toString();
      Uint8List imageBytes = base64Decode(base64Image);
      return MemoryImage(imageBytes);
    }
  }

  Container news_lihatsemua(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
      ),
      width: MediaQuery.of(context).size.width,
      height: 30,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("News"),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.NEWS);
            },
            child: Text(
              "Lihat Semua",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container view_list_view() {
    return Container(
      height: 160,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            return true;
          } else if (notification is ScrollEndNotification) {
            return true;
          }
          return false;
        },
        child: ListView.builder(
          controller: controller.scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: controller.contentNews.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => WebViewPage(
                      url: controller.contentNews[index].webContentUrl
                          .toString(),
                      namaPage: controller.contentNews[index].webContentTitle
                          .toString(),
                    ));
              },
              child: Container(
                width: Get.width * 0.9,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 4,
                        offset: Offset(2.0, 2.0),
                      )
                    ]),
                child: Center(
                  child: Row(
                    children: [
                      Container(
                        width: 200,
                        color: Colors.white,
                        margin: EdgeInsets.only(
                          left: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${controller.contentNews[index].webContentTitle}",
                              maxLines: 3,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              controller.contentNews[index].webContentDate
                                  .toString(),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Text(controller
                                .contentNews[index].webContentDescription
                                .toString()),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          image: DecorationImage(
                              image: base64News(index), fit: BoxFit.fitWidth),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Container indicator() {
    return Container(
      height: 10,
      color: Colors.white,
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            controller.contentNews.length,
            (index) => GestureDetector(
              onTap: () {
                controller.scrollController.animateTo(
                  Get.width * 0.8 * index,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Container(
                width: 10,
                height: 10,
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: controller.currentPage.value == index
                      ? Colors.orange
                      : Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
