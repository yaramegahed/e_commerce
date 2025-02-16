import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/home_cubit/home_cubit.dart';
import 'package:e_commerce/core/models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomProductList extends StatelessWidget {
  final bool? wrap;
  final ScrollPhysics? physics;
  final HomeModel? model;
  final String? query;
  final String? category;
  final void Function()? onPressed;

  const CustomProductList(
      {super.key,
      this.wrap,
      this.physics,
      this.model,
      this.query,
      this.category, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getProducts( query: query,category: category),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          HomeCubit cubit = BlocProvider.of(context);
          List<HomeModel> products = cubit.products;
          return Container(
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
                      child: Center(
                        child: CachedNetworkImage(
                          imageUrl: model?.images ??
                              "https://img.freepik.com/free-vector/3d-wood-podium-wooden-product-display-pedestal_107791-29016.jpg?t=st=1738432246~exp=1738435846~hmac=797711586e46cec765dcc3fb2330066ef61a5ba9989d21c07b1f5b9b68828cec&w=900",
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      Spacer(),
                      IconButton(onPressed: onPressed, icon: Icon(Icons.favorite))
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
                        onTap: () {},
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue),
                          child: Center(
                              child: Text(
                            "Buy now",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
