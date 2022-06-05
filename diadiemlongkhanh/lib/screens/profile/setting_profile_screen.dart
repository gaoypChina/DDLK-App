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
      'Cập nhật thông tin',
      type: SettingMenuType.editProfile,
    ),
    SettingMenuModel(
      SvgPicture.asset(ConstantIcons.ic_lock_fill),
      'Đổi mật khẩu',
      type: SettingMenuType.changePassword,
    ),
  ];

  _selectMenu(SettingMenuType type) {
    if (type == SettingMenuType.editProfile) {
      Navigator.of(context).pushNamed(
        RouterName.edit_profile,
      );
    } else if (type == SettingMenuType.changePassword) {
      Navigator.of(context).pushNamed(
        RouterName.reset_password,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.grey_F2F4F8,
      appBar: MyAppBar(
        title: 'Cài đặt',
      ),
      body: ListView.builder(
        itemCount: settingItems.length,
        // shrinkWrap: true,
        itemBuilder: (_, index) {
          final item = settingItems[index];
          return SettingItemView(
            item,
            onPressed: () => _selectMenu(item.type),
          );
        },
      ),
    );
  }
}
