import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: ColorConstant.grey_F8F9FA,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
