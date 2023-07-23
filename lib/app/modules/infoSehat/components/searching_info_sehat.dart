import 'package:flutter/material.dart';
import '../controllers/info_sehat_controller.dart';

class SearchingInfoSehat extends StatelessWidget {
  const SearchingInfoSehat({
    super.key,
    required this.controller,
  });

  final InfoSehatController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.inputSearch,
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
            controller.searchText.value = controller.inputSearch.text;
          },
        ),
      ),
    );
  }
}
