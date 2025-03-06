
import 'package:e_commerce/core/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../widget/custom_product_list.dart';

class CategoryScreen extends StatelessWidget {
   const CategoryScreen({super.key, required this.category, });
  final String category;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(title: category),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            SizedBox(height: 10,),
            CustomProductList(category: category,)
          ],
        ),
      ),
    );
  }
}
