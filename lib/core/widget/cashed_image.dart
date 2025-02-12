import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CashedImage extends StatelessWidget {
  const CashedImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: 250,
      imageUrl:
      "https://img.freepik.com/free-vector/3d-wood-podium-wooden-product-display-pedestal_107791-29016.jpg?t=st=1738432246~exp=1738435846~hmac=797711586e46cec765dcc3fb2330066ef61a5ba9989d21c07b1f5b9b68828cec&w=900",
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
