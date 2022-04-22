import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'main_text_form_field.dart';

class SearchFormField extends StatelessWidget {
  final Color? fillColor;
  SearchFormField({
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
        bottom: 32,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: MainTextFormField(
          fillColor: fillColor ?? ColorConstant.neutral_gray_lightest,
          hideBorder: true,
          hintText: 'Nhập địa điểm cần tìm',
          prefixIcon: SvgPicture.asset(
            ConstantIcons.ic_search,
          ),
        ),
      ),
    );
  }
}
