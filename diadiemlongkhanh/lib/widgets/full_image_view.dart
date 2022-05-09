import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FullImageView extends StatelessWidget {
  final String url;
  FullImageView(this.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 20,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      ConstantIcons.ic_close,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 100,
              bottom: 100,
              child: InteractiveViewer(
                boundaryMargin: EdgeInsets.all(80),
                minScale: 1,
                maxScale: 2,
                panEnabled: true,
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
            ),
          ],
        ),
      ),
    );
  }
}
