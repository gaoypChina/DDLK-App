import 'package:diadiemlongkhanh/models/local/setting_menu_model.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingItemView extends StatelessWidget {
  final SettingMenuModel item;
  final Function()? onPressed;
  SettingItemView(
    this.item, {
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: ColorConstant.neutral_gray_lightest,
            ),
          ),
        ),
        child: Row(
          children: [
            item.icon,
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                item.title,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            SvgPicture.asset(
              ConstantIcons.ic_chevron_right,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
