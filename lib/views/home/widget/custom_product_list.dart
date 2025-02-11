import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/views/product_details/view/product_details_screen.dart';
import 'package:flutter/material.dart';

class CustomProductList extends StatelessWidget {
  final bool wrap;
  final ScrollPhysics? physics;

  const CustomProductList({super.key, required this.wrap, this.physics});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: wrap,
      physics: physics,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(),
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
                      child: Center(
                        child: CachedNetworkImage(
                          imageUrl:
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
                        "10% OFF",
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
                      Text("Product name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      Spacer(),
                      IconButton(onPressed: () {}, icon: Icon(Icons.favorite))
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
                            "200 LE",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            "210 LE",
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
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 10,
        );
      },
      itemCount: 4,
    );
  }
}
