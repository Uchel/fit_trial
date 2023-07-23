import 'package:flutter/material.dart';
import '../controllers/news_controller.dart';

class SearchingNews extends StatelessWidget {
  const SearchingNews({
    super.key,
    required this.controller,
  });

  final NewsController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.inputSearch2,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[300],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        hintText: 'Cari Sesuatu...',
        suffixIcon: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            controller.searchText2.value = controller.inputSearch2.text;
          },
        ),
      ),
    );
  }
}
