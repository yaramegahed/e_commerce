import 'package:e_commerce/core/home_cubit/home_cubit.dart';
import 'package:e_commerce/core/models/home_model.dart';
import 'package:e_commerce/views/home/widget/custom_product_list.dart';
import 'package:e_commerce/views/home/widget/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../product_details/view/product_details_screen.dart';

class ShopScreen extends StatelessWidget {
  final HomeModel? model;

  const ShopScreen({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit =BlocProvider.of(context);
    List<HomeModel> products = cubit.products;
    return BlocProvider(
      create: (context) => HomeCubit()..getProducts(),
      child: Scaffold(
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
                CustomSearchField(
                  onPressed: () {}, controller: TextEditingController(),),
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
                                  builder: (context) => ProductDetailsScreen(model: products[index],),
                                ));
                          },
                          child: CustomProductList(
                            model: products[index],
                            wrap: false,
                            physics: AlwaysScrollableScrollPhysics(),
                            isFav: true,
                          ));
                    }, separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 10,);
                  }, itemCount: products.length,),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
