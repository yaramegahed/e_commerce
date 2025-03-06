import 'package:flutter/material.dart';

import '../view/category/category_screen.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
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
                      category: categories[index].text,
                    ),
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
    );
  }
}
final List<Category> categories = [
  Category(icon: Icons.sports, text: "Sports"),
  Category(icon: Icons.tv, text: "Electronics"),
  Category(icon: Icons.mood_outlined, text: "Skin care"),
  Category(icon: Icons.shopping_cart, text: "clothes"),
  Category(icon: Icons.book, text: "Books"),
  Category(icon: Icons.gamepad, text: "Gaming"),
];
class Category {
  final IconData icon;
  final String text;

  Category({required this.icon, required this.text});
}
