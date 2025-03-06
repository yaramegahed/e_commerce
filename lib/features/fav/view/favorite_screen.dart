import 'package:e_commerce/core/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../home/widget/custom_product_list.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Favorites"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView(
                children: [
                  CustomProductList(
                    isFav: true,
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
