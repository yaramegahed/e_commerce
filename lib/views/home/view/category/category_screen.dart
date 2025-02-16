import 'package:e_commerce/core/home_cubit/home_cubit.dart';
import 'package:e_commerce/core/models/home_model.dart';
import 'package:e_commerce/core/widget/custom_app_bar.dart';
import 'package:e_commerce/views/home/widget/custom_product_list.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
   CategoryScreen({super.key, required this.category, this.model});
  final String category;
  final HomeModel? model;
  final HomeCubit cubit=HomeCubit();

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
