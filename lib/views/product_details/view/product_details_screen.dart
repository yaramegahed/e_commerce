import 'package:e_commerce/core/widget/custom_app_bar.dart';
import 'package:e_commerce/core/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

import '../../../core/widget/cashed_image.dart';
import '../widget/comments_list.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  double rating = 3.5;
  int starCount = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Product Details",),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CashedImage(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Product Name",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "110 LE",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "3",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 30,
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.grey,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Product Rate",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  StarRating(
                    size: 40.0,
                    color: Colors.amber,
                    borderColor: Colors.grey,
                    allowHalfRating: true,
                    rating: rating,
                    starCount: starCount,
                    onRatingChanged: (rating) => setState(() {
                      this.rating = rating;
                    }),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    label: "Type your feedback",
                    hint: "Type your feedback",
                    suffixIcon: Icons.send,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        "Comments",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CommentsList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
