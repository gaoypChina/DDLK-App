import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:flutter/material.dart';

class ClipRRectImage extends StatelessWidget {
  final String? url;
  final double radius;
  final double? width;
  final double? height;
  ClipRRectImage({
    this.url,
    this.radius = 0,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: FadeInImage.assetNetwork(
        placeholder: ConstantImages.placeholder,
        fadeInDuration: Duration(milliseconds: 100),
        fadeOutDuration: Duration(milliseconds: 100),
        image: url ?? '',
        width: width,
        height: height,
        fit: BoxFit.cover,
        imageErrorBuilder: (context, exception, stackTrace) {
          return Image.asset(
            ConstantImages.placeholder,
            width: width,
            height: height,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
