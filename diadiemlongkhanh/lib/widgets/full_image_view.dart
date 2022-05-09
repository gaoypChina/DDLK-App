import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:flutter/material.dart';

class FullImageView extends StatelessWidget {
  final String url;
  FullImageView(this.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.6),
      body: Stack(
        children: [
          Positioned(
            top: 100,
            bottom: 100,
            child: FadeInImage.assetNetwork(
              placeholder: ConstantImages.placeholder,
              fadeInDuration: Duration(milliseconds: 100),
              fadeOutDuration: Duration(milliseconds: 100),
              image: url,
              fit: BoxFit.cover,
              imageErrorBuilder: (context, exception, stackTrace) {
                return Image.asset(
                  ConstantImages.placeholder,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
