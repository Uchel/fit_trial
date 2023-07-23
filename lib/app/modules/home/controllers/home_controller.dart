import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../model/content_type.dart';

class HomeController extends GetxController {
  final Dio dio = Dio();
  final String apiUrl1 =
      "https://development.inhealth.co.id/ft-svc/api/GeneratorInhealthEncryptDataWithPub";
  final String apiUrl2 =
      "https://development.inhealth.co.id/ft-svc/api/NWGetTrxWebContent";

//===================================================================== Variabel , List dll
  var isLoading = true.obs;

  var isSearchAppBar = false.obs;
  var atmCard = "".obs; //bottomsheet image

  RxList<ModelContent> contentInfoSehat = <ModelContent>[].obs;
  RxList<ModelContent> contentNews = <ModelContent>[].obs;

//====================================================================== API
//get bottomsheet image API
  Future getApiCard() async {
    try {
      var response = await Dio().post(
          "https://development.inhealth.co.id/ft-svc/api/GeneratorInhealthEncryptDataWithPub",
          data: {
            "nomorKartuInhealth": "1001000154172",
            "kodeProduk": "M",
            "username": "6289607266532",
            "offset": "0",
            "limit": "10",
            "cardNumber": "1001000154172"
          });
      var response2 = await Dio().post(
          "https://development.inhealth.co.id/ft-svc/api/NWGetECard",
          data: response.data.toString().replaceAll('"', '\\"'));

      atmCard.value = (json.decode(response2.data))["data"]["strCard"];
    } catch (e) {
      print("Gagal Get Api Card $e");
    }
  }

//get content get API=
  Future<void> getApiContent() async {
    try {
      final response = await dio.post(apiUrl1, data: {
        "username": "6285333111623",
        "nomorKartuInhealth": "1001538370697",
        "udid": "06abd25e57a14579",
        "deviceType": "Android",
        "webContentTittleTp": "",
        "offset": 0,
        "limit": 100
      });
      var responseDat = await Dio().post(
          "https://development.inhealth.co.id/ft-svc/api/NWGetTrxWebContent",
          data: response.data.toString().replaceAll('"', '\\"'));

      final List<dynamic> responseData =
          (json.decode(responseDat.data) as Map<String, dynamic>)["datas"];
      final List<ModelContent> filteredInfoSehatList = responseData
          .map((data) => ModelContent.fromJson(data))
          .where((title) => title.webContentTitleTpNm == "Info Sehat")
          .toList();
      final List<ModelContent> filteredNewsList = responseData
          .map((data) => ModelContent.fromJson(data))
          .where((title) => title.webContentTitleTpNm == "News")
          .toList();

      contentInfoSehat.assignAll(filteredInfoSehatList);
      contentNews.assignAll(filteredNewsList);
    } catch (e) {
      print('Error fetching data from API: $e');
    } finally {
      isLoading.value = false;
    }
  }

  //Untuk Slider news
  RxInt currentPage = 0.obs;

  ScrollController scrollController = ScrollController();

  void onScroll() {
    double itemWidth = Get.width * 0.9;
    int currentPageValue = (scrollController.offset / itemWidth).round();
    currentPage.value = currentPageValue;
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(onScroll);
  }

  @override
  void onClose() {
    scrollController.removeListener(onScroll);
    scrollController.dispose();
    super.onClose();
  }
}
