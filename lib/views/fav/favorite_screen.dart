import 'package:flutter/material.dart';

import '../home/widget/custom_product_list.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

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
                "Favorites",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
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
