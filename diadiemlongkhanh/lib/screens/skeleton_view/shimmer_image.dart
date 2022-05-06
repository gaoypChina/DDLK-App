import 'package:flutter/material.dart';

class ShimmerImage extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxShape shape;
  ShimmerImage({
    this.width,
    this.height,
    this.shape = BoxShape.rectangle,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius:
            shape == BoxShape.circle ? null : BorderRadius.circular(4),
        color: Color(0xffEBEBEB),
        shape: shape,
      ),
    );
  }
}
