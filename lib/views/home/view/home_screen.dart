import 'package:e_commerce/core/home_cubit/home_cubit.dart';
import 'package:e_commerce/views/home/view/category/category_screen.dart';
import 'package:e_commerce/views/home/view/search/search_screen.dart';
import 'package:e_commerce/views/home/widget/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/home_model.dart';
import '../../product_details/view/product_details_screen.dart';
import '../widget/custom_product_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  String? query;
  String? category;

  final List<Category> categories = [
    Category(icon: Icons.sports, text: "Sports"),
    Category(icon: Icons.tv, text: "Electronics"),
    Category(icon: Icons.collections, text: "Collections"),
    Category(icon: Icons.shopping_cart, text: "cloths"),
    Category(icon: Icons.book, text: "Books"),
    Category(icon: Icons.gamepad, text: "Gaming"),
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getProducts(query: query),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          HomeCubit cubit = BlocProvider.of(context);
          List<HomeModel> products = query != null
              ? cubit.searchProducts
              : category != null
                  ? cubit.categoriesProducts
                  : cubit.products;
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    CustomSearchField(
                      onPressed: () {
                        if (searchController.text.isNotEmpty) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchScreen(
                                  query: searchController.text,
                                ),
                              ));
                        }
                        searchController.clear();
                      },
                      controller: searchController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/ecom.gif",
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Popular",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 100,
                              child: ListView.separated(
                                shrinkWrap: true,
                                separatorBuilder: (context, index) => SizedBox(
                                  width: 10,
                                ),
                                scrollDirection: Axis.horizontal,
                                itemCount: categories.length,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CategoryScreen(
                                              category: categories[index].text,model: products[index],),
                                        ));
                                  },
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 35,
                                        backgroundColor: Colors.blue,
                                        child: Icon(
                                          categories[index].icon,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                      ),
                                      Text(
                                        categories[index].text,
                                        style: TextStyle(fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "Recently Products",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailsScreen(
                                            model: products[index],
                                          ),
                                        ));
                                  },
                                  child: CustomProductList(
                                    isFav: cubit.checkFav(products[index].productId!),
                                    onPressed: (){
                                      bool isFav=cubit.checkFav(products[index].productId!);
                                      isFav ?cubit.removeFav(products[index].productId!)
                                      :cubit.addToFav(products[index].productId!);
                                    },
                                    model: products[index],
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 10,
                                );
                              },
                              itemCount: products.length,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Category {
  final IconData icon;
  final String text;

  Category({required this.icon, required this.text});
}
