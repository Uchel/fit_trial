import 'package:fit_aja2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import '../../home/model/content_type.dart';

class NewsController extends HomeController {
  var searchText2 = ''.obs;
  TextEditingController inputSearch2 = TextEditingController();
  List<ModelContent> get filteredDataNews {
    // Jika searchText kosong, tampilkan semua data
    if (searchText2.isEmpty) return contentNews;

    // Jika searchText tidak kosong, filter data berdasarkan nilai searchText
    return contentNews
        .where((title) => title.webContentTitle!
            .toLowerCase()
            .contains(searchText2.value.toLowerCase()))
        .toList();
  }
}
