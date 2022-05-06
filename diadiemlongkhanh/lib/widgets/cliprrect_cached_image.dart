import 'package:cached_network_image/cached_network_image.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:flutter/material.dart';

class ClipRRectCachedImage extends StatelessWidget {
  final String? url;
  final double radius;
  final double? width;
  final double? height;
  ClipRRectCachedImage({
    this.url,
    this.radius = 0,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: url ?? '',
        placeholder: (context, url) => Image.asset(ConstantImages.placeholder),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
