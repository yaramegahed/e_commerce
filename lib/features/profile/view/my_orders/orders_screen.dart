import 'package:e_commerce/core/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../home/widget/custom_product_list.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "My Orders"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
        child: Column(
          children: [
            Expanded(
                child: CustomProductList(
                  isOrder: true,
                  wrap: false,
                  physics: AlwaysScrollableScrollPhysics(),
                )),
          ],
        ),
      ),
    );
  }
}
