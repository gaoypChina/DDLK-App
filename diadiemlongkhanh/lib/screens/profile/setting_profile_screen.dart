import 'package:diadiemlongkhanh/models/local/setting_menu_model.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/screens/profile/widgets/setting_item_view.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingProfileScreen extends StatefulWidget {
  const SettingProfileScreen({Key? key}) : super(key: key);

  @override
  _SettingProfileScreenState createState() => _SettingProfileScreenState();
}

class _SettingProfileScreenState extends State<SettingProfileScreen> {
  final settingItems = [
    SettingMenuModel(
      Image.asset(
        ConstantIcons.ic_profile_edit,
        width: 24,
        height: 24,
      ),
      'Tài khoản và bảo mật',
    ),
    SettingMenuModel(
      SvgPicture.asset(ConstantIcons.ic_lock_fill),
      'Quyền riêng tư',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.grey_F2F4F8,
      appBar: MyAppBar(
        title: 'Cài đặt',
        isShowBgBackButton: false,
      ),
      body: ListView.builder(
        itemCount: settingItems.length,
        // shrinkWrap: true,
        itemBuilder: (_, index) {
          final item = settingItems[index];
          return SettingItemView(
            item,
            onPressed: () => Navigator.of(context).pushNamed(
              RouterName.edit_profile,
            ),
          );
        },
      ),
    );
  }
}
