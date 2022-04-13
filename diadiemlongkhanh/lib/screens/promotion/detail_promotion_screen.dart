import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:flutter/material.dart';

class DetailPromotionScreen extends StatefulWidget {
  const DetailPromotionScreen({Key? key}) : super(key: key);

  @override
  State<DetailPromotionScreen> createState() => _DetailPromotionScreenState();
}

class _DetailPromotionScreenState extends State<DetailPromotionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.grey_F2F4F8,
      appBar: MyAppBar(
        title: 'Chi tiết khuyến mãi',
        isShowBgBackButton: false,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              bottom: 0,
              child: Image.asset(
                ConstantImages.left_pin,
                width: 153,
                height: 116,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 120,
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    ClipRRectImage(
                      radius: 8,
                      height: 286,
                      width: double.infinity,
                      url:
                          'https://img.giftpop.vn/brand/GOGIHOUSE/MP1905280011_BASIC_origin.jpg',
                    ),
                    Positioned(
                      top: 250,
                      left: 16,
                      right: 16,
                      bottom: 0,
                      child: Column(
                        children: [
                          Container(
                            height: 228,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
