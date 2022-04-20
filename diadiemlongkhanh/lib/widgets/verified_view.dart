import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VerifiedView extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  VerifiedView({
    this.margin,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      width: 70,
      margin: margin,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 11,
            width: 11,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: ColorConstant.orange_secondary,
            ),
            child: SvgPicture.asset(
              ConstantIcons.ic_check,
            ),
          ),
          SizedBox(
            width: 2,
          ),
          Text(
            'Đã xác minh',
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
