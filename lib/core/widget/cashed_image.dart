import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CashedImage extends StatelessWidget {
  final String url;
  const CashedImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
      url,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
