import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/views/home/widget/custom_search_field.dart';
import 'package:flutter/material.dart';

import '../widget/custom_product_list.dart';

class HomeScreen extends StatelessWidget {
  final List<Category> categories = [
    Category(icon: Icons.sports, text: "Sports"),
    Category(icon: Icons.tv, text: "Electronics"),
    Category(icon: Icons.collections, text: "Collections"),
    Category(icon: Icons.book, text: "Books"),
    Category(icon: Icons.gamepad, text: "Gaming"),
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              CustomSearchField(),
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
                          separatorBuilder: (context, index) =>
                              SizedBox(
                                width: 10,
                              ),
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) =>
                              Column(
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
                      Text(
                        "Recently Products",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomProductList(wrap: true,physics: NeverScrollableScrollPhysics(),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Category {
  final IconData icon;
  final String text;

  Category({required this.icon, required this.text});
}
