import 'package:e_commerce/core/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/view/search/search_screen.dart';
import '../../home/widget/custom_product_list.dart';
import '../../home/widget/custom_search_field.dart';

class ShopScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  ShopScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {
                    if (searchController.text.isNotEmpty) {
                      String query = searchController.text;
                      searchController.clear();

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchScreen(
                              query: query,
                            ),
                          ));
                    }
                  },
                  controller: searchController,
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView(
                    children: [CustomProductList()],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
