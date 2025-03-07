import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/models/home_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';
import '../../../core/widget/custom_buy_button.dart';
import '../../product_details/view/product_details_screen.dart';

class CustomContainer extends StatelessWidget {
  final HomeModel? model;
  final bool isFav;
  final void Function() onPressed;
  final void Function() onPaymentSuccess;

  const CustomContainer(
      {super.key,
      required this.model,
      required this.onPressed,
      required this.isFav,
      required this.onPaymentSuccess});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                model: model,
              ),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20)),
            color: Colors.grey.shade300,
            boxShadow: [
              BoxShadow(
                color: Colors.black,
              )
            ]),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  child: CachedNetworkImage(
                    height: 250,
                    imageUrl: model?.images ??
                        "https://img.freepik.com/free-vector/3d-wood-podium-wooden-product-display-pedestal_107791-29016.jpg?t=st=1738432246~exp=1738435846~hmac=797711586e46cec765dcc3fb2330066ef61a5ba9989d21c07b1f5b9b68828cec&w=900",
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Positioned(
                    child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: Colors.blue),
                  child: Center(
                      child: Text(
                    "${model?.sale ?? "5"}% OFF",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
                ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Text(model?.productName ?? "no name",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Spacer(),
                  IconButton(
                      onPressed: onPressed,
                      icon: Icon(
                        Icons.favorite,
                        color: isFav ? Colors.red : Colors.grey,
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        "${model?.price ?? "no price"} LE",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        "${model?.oldPrice ?? "no old price"} LE",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentView(
                            onPaymentSuccess: () {
                              onPaymentSuccess();
                              if (kDebugMode) {
                                print("success");
                              }

                            },
                            onPaymentError: () {
                              if (kDebugMode) {
                                print("failure");
                              }
                            },
                            price: double.parse(model?.price ??
                                "no price"), // Required: Total price (e.g., 100 for 100 EGP)
                          ),
                        ),
                      );
                    },
                    child: CustomBuyButton(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
