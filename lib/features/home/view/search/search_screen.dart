import 'package:e_commerce/core/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../widget/custom_product_list.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, required this.query,});
  final String query;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(title: "search results "),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            SizedBox(height: 10,),
            CustomProductList(query: query,)
          ],
        ),
      ),
    );
  }
}
