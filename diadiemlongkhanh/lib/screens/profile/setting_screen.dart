import 'package:diadiemlongkhanh/models/local/setting_menu_model.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/screens/profile/widgets/setting_item_view.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
      SvgPicture.asset(ConstantIcons.ic_setting),
      'Quyền riêng tư',
    ),
    SettingMenuModel(
      Image.asset(
        ConstantIcons.ic_bell_fill,
        width: 24,
        height: 24,
      ),
      'Cài đặt thông báo',
    ),
    SettingMenuModel(
      SvgPicture.asset(ConstantIcons.ic_qr_black),
      'Quét mã QR',
    ),
    SettingMenuModel(
      SvgPicture.asset(ConstantIcons.ic_contact),
      'Liên hệ góp ý',
    ),
    SettingMenuModel(
      SvgPicture.asset(ConstantIcons.ic_logout),
      'Đăng xuất',
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
            onPressed: () =>
                Navigator.of(context).pushNamed(RouterName.setting_profile),
          );
        },
      ),
    );
  }
}
