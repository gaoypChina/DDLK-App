import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyBackButton extends StatelessWidget {
  final bool isShowBgBackButton;
  final Color color;
  MyBackButton({
    this.isShowBgBackButton = false,
    this.color = ColorConstant.grey_F8F9FA,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Center(
        child: Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            color: isShowBgBackButton ? color : Colors.transparent,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Center(
            child: SvgPicture.asset(ConstantIcons.ic_chevron_left),
          ),
        ),
      ),
    );
  }
}
