import 'package:fit_aja2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import '../../home/model/content_type.dart';

class InfoSehatController extends HomeController {
  //TODO: Implement InfoSehatController

  TextEditingController inputSearch = TextEditingController();
  var contentInfoSehat = <ModelContent>[].obs;
  var searchText = ''.obs;

  List<ModelContent> get filteredDataInfoSehat {
    // Jika searchText kosong, tampilkan semua data
    if (searchText.isEmpty) return contentInfoSehat;

    // Jika searchText tidak kosong, filter data berdasarkan nilai searchText
    return contentInfoSehat
        .where((title) => title.webContentTitle!
            .toLowerCase()
            .contains(searchText.value.toLowerCase()))
        .toList();
  }
}
