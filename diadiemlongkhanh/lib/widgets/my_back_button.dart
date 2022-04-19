import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyBackButton extends StatelessWidget {
  final bool isShowBgBackButton;
  MyBackButton({
    this.isShowBgBackButton = false,
  });
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: isShowBgBackButton
              ? ColorConstant.grey_F8F9FA
              : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: SvgPicture.asset(ConstantIcons.ic_chevron_left),
        ),
      ),
    );
  }
}
