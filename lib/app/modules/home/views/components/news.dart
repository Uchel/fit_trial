// import 'dart:convert';

import 'dart:convert';

import 'dart:typed_data';

import 'package:fit_aja2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../webview.dart';
import '../../controllers/home_controller.dart';

class NewsContainer extends StatelessWidget {
  const NewsContainer({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: MediaQuery.of(context).size.width,
      height: 225,
      color: Colors.white,
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: 220,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("News"),
                      GestureDetector(
                        child: Text(
                          "Lihat Semua",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Get.toNamed(Routes.NEWS);
                        },
                      ),
                    ],
                  ),
                ),
                SlideIndicator(
                  controller: controller,
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: 150,
            child: FutureBuilder(
                future: controller.getApiContent(),
                builder: (context, snapshot) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var index = 0;
                            index < controller.contentNews.take(5).length;
                            index++)
                          BigContainer(
                            controller: controller,
                            index: index,
                          ),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class SlideIndicator extends StatelessWidget {
  const SlideIndicator({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var index = 0;
            index < controller.contentNews.take(5).length;
            index++)
          Container(
            margin: EdgeInsets.only(
              right: 5,
            ),
            child: Text(
              ".",
              style: TextStyle(
                color: Colors.amber,
                fontSize: 60,
              ),
            ),
          ),
      ],
    );
  }
}

class BigContainer extends StatelessWidget {
  const BigContainer(
      {super.key, required this.controller, required this.index});
  final HomeController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => WebViewPage(
              url: controller.contentNews[index].webContentUrl.toString(),
              namaPage:
                  controller.contentNews[index].webContentTitle.toString(),
            ));
      },
      child: Container(
        margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: Offset(4.0, 3.0),
              blurRadius: 5,
            ),
            BoxShadow(
              color: Colors.grey.shade300,
              offset: Offset(0, -1.0),
              blurRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Container(
                    width: 150,
                    color: Colors.white,
                    child: Text(
                      "${controller.contentNews[index].webContentTitle}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 3,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    child: Text(
                      "${controller.contentNews[index].webContentDate}",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    width: 150,
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 150,
                    child: Text(
                      "${controller.contentNews[index].webContentDescription}",
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
                image: DecorationImage(
                    image: base64News(index), fit: BoxFit.fitWidth),
              ),
            )
          ],
        ),
      ),
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
      // Kembalikan MemoryImage kosong sebagai placeholder
      String base64Image =
          controller.contentInfoSehat[0].webContentImage.toString();
      Uint8List imageBytes = base64Decode(base64Image);
      return MemoryImage(imageBytes);
    }
  }
}
