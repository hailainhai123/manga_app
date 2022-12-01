import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer_widget/templates_shimmer_widget.dart';

class NetWorkImageApp extends StatelessWidget {
  final String urlImage;
  final BoxFit? fit;

  const NetWorkImageApp({super.key, required this.urlImage, this.fit});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: urlImage,
      fit: fit ?? BoxFit.fitHeight,
      placeholder: (context, url) => const Center(
        child:
            SizedBox(width: 30, height: 30, child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => SizedBox(),
    );
  }
}
