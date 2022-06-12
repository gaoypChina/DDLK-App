import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/widgets/full_image_view.dart';
import 'package:flutter/material.dart';

class ClipRRectImage extends StatelessWidget {
  final String? url;
  final double radius;
  final double? width;
  final double? height;
  final Function()? onPressed;
  ClipRRectImage({
    this.url,
    this.radius = 0,
    this.width,
    this.height,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: url == null || url!.contains('svg') || url == ''
          ? ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Image.asset(
                ConstantImages.placeholder,
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Image.network(
                url ?? '',
                width: width,
                height: height,
                fit: BoxFit.cover,
                errorBuilder: (context, exception, stackTrace) {
                  return Image.asset(
                    ConstantImages.placeholder,
                    width: width,
                    height: height,
                    fit: BoxFit.cover,
                  );
                },
              ),
              // FadeInImage.assetNetwork(
              //   placeholder: ConstantImages.placeholder,
              //   fadeInDuration: Duration(milliseconds: 20),
              //   fadeOutDuration: Duration(milliseconds: 20),
              //   image: url ?? '',
              //   width: width,
              //   height: height,
              //   fit: BoxFit.cover,
              //   imageErrorBuilder: (context, exception, stackTrace) {
              //     return Image.asset(
              //       ConstantImages.placeholder,
              //       width: width,
              //       height: height,
              //       fit: BoxFit.cover,
              //     );
              //   },
              // ),
            ),
    );
  }
}
