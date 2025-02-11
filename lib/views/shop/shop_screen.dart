import 'package:e_commerce/views/home/widget/custom_product_list.dart';
import 'package:e_commerce/views/home/widget/custom_search_field.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome to our store",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              CustomSearchField(),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: CustomProductList(
                wrap: false,
                physics: AlwaysScrollableScrollPhysics(),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
