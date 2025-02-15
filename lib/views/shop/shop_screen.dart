import 'package:e_commerce/views/home/widget/custom_product_list.dart';
import 'package:e_commerce/views/home/widget/custom_search_field.dart';
import 'package:flutter/material.dart';

import '../product_details/view/product_details_screen.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Welcome to our store",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomSearchField(),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(),
                              ));
                        },
                        child: CustomProductList(
                          wrap: false,
                          physics: AlwaysScrollableScrollPhysics(),
                        ));
                  }, separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10,);
                }, itemCount: 4,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
