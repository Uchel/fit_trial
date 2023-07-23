// import 'dart:convert';

import 'dart:convert';

import 'package:fit_aja2/app/modules/home/views/webview.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../home/views/loading.dart';
import '../components/searching_info_sehat.dart';
import '../controllers/info_sehat_controller.dart';

class InfoSehatView extends GetView<InfoSehatController> {
  const InfoSehatView({Key? key}) : super(key: key);
  @override
  // TODO: implement controller
  InfoSehatController get controller => super.controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'InfoSehat',
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
            SearchingInfoSehat(controller: controller),
            SizedBox(height: 20),
            FutureBuilder(
              future: controller.getApiContent(),
              builder: (context, snapshot) {
                return Expanded(
                  child: Obx(
                    () => controller.isLoading.value
                        ? Loading()
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                for (var index = 0;
                                    index <
                                        controller.filteredDataInfoSehat.length;
                                    index += 2)
                                  Row(
                                    children: [
                                      _container1(index, context),
                                      if (index + 1 <
                                          controller
                                              .filteredDataInfoSehat.length)
                                        _conteiner2(index, context),
                                    ],
                                  ),
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

  Widget _container1(int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => WebViewPage(
              url: controller.filteredDataInfoSehat[index].webContentUrl
                  .toString(),
              namaPage: controller.filteredDataInfoSehat[index].webContentTitle
                  .toString(),
            ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        height: 270,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey, width: 1),
          ),
        ),
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                image: DecorationImage(
                  image: MemoryImage(
                    base64Decode(controller
                        .filteredDataInfoSehat[index].webContentImage
                        .toString()),
                  ),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Text(
                "${controller.filteredDataInfoSehat[index].webContentTitle}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Text(
                "${controller.filteredDataInfoSehat[index].webContentDate}",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Text(
                "${controller.filteredDataInfoSehat[index].webContentDescription}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _conteiner2(int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => WebViewPage(
              url: controller.filteredDataInfoSehat[index + 1].webContentUrl
                  .toString(),
              namaPage: controller
                  .filteredDataInfoSehat[index + 1].webContentTitle
                  .toString(),
            ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        height: 270,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey, width: 1),
          ),
        ),
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                image: DecorationImage(
                  image: MemoryImage(
                    base64Decode(controller
                        .filteredDataInfoSehat[index + 1].webContentImage
                        .toString()),
                  ),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Text(
                "${controller.filteredDataInfoSehat[index + 1].webContentTitle}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Text(
                "${controller.filteredDataInfoSehat[index + 1].webContentDate}",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Text(
                "${controller.filteredDataInfoSehat[index + 1].webContentDescription}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
