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
      child: Image.network(
        url ?? '',
        width: width,
        height: height,
        fit: BoxFit.fill,
      ),
    );
  }
}
