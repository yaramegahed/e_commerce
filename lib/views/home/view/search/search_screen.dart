import 'package:e_commerce/core/models/home_model.dart';
import 'package:e_commerce/core/widget/custom_app_bar.dart';
import 'package:e_commerce/views/home/widget/custom_product_list.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, required this.query, this.model});
  final String query;
  final HomeModel? model;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(title: "search results "),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            SizedBox(height: 10,),
            CustomProductList(query: query,model: model, isFav: true,)
          ],
        ),
      ),
    );
  }
}
