// import 'dart:convert';

import 'dart:convert';
import 'dart:typed_data';

import 'package:fit_aja2/app/modules/home/views/loading.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../home/views/webview.dart';
import '../components/serching_news.dart';
import '../controllers/news_controller.dart';

class NewsView extends GetView<NewsController> {
  const NewsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'News',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SearchingNews(controller: controller),
            FutureBuilder(
              future: controller.getApiContent(),
              builder: (context, snapshot) {
                return Expanded(
                  child: Obx(
                    () => controller.isLoading.value
                        ? Loading()
                        : Center(
                            child: ListView(
                              children: [
                                for (var index = 0;
                                    index < controller.filteredDataNews.length;
                                    index++)
                                  _container(index, context),
                              ],
                            ),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _container(int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => WebViewPage(
              url: controller.filteredDataNews[index].webContentUrl.toString(),
              namaPage:
                  controller.filteredDataNews[index].webContentTitle.toString(),
            ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        decoration: BoxDecoration(),
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: base64News(index),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              width: 180,
              height: 200,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${controller.filteredDataNews[index].webContentTitle}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${controller.filteredDataNews[index].webContentDate}",
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${controller.filteredDataNews[index].webContentDescription}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
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
          controller.filteredDataNews[index].webContentImage.toString();
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
}
