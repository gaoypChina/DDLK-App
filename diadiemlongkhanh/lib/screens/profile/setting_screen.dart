import 'package:diadiemlongkhanh/models/local/setting_menu_model.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/screens/profile/widgets/setting_item_view.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/services/storage/storage_service.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/utils/global_value.dart';
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
      type: SettingMenuType.settingProfile,
    ),
    // SettingMenuModel(
    //   SvgPicture.asset(ConstantIcons.ic_setting),
    //   'Quyền riêng tư',
    // ),
    // SettingMenuModel(
    //   Image.asset(
    //     ConstantIcons.ic_bell_fill,
    //     width: 24,
    //     height: 24,
    //   ),
    //   'Cài đặt thông báo',
    // ),
    SettingMenuModel(
      SvgPicture.asset(ConstantIcons.ic_qr_black),
      'Quét mã QR',
      type: SettingMenuType.scan,
    ),
    SettingMenuModel(
      SvgPicture.asset(ConstantIcons.ic_contact),
      'Liên hệ góp ý',
      type: SettingMenuType.contact,
    ),
    SettingMenuModel(
      SvgPicture.asset(ConstantIcons.ic_logout),
      'Đăng xuất',
      type: SettingMenuType.logout,
    ),
    SettingMenuModel(
      Icon(
        Icons.remove_circle,
        color: ColorConstant.sematic_red,
      ),
      'Xóa tài khoản',
      type: SettingMenuType.delete,
    ),
  ];
  _selectMenu(SettingMenuType type) {
    if (type == SettingMenuType.settingProfile) {
      Navigator.of(context).pushNamed(RouterName.setting_profile);
    } else if (type == SettingMenuType.contact) {
      Navigator.of(context).pushNamed(RouterName.contact);
    } else if (type == SettingMenuType.scan) {
      Navigator.of(context).pushNamed(RouterName.scan);
    } else if (type == SettingMenuType.delete) {
      AppUtils.showOkDialog(
        context,
        'Bạn chắc chắn muốn xóa tài khoản? Sau khi tài khoản được xóa thành công, mọi thông tin của bạn đã cung cấp sẽ được xóa vĩnh viễn!',
        okAction: _delete,
        isCancel: true,
      );
    } else if (type == SettingMenuType.logout) {
      AppUtils.showOkDialog(
        context,
        'Bạn chắc chắn muốn đăng xuất?',
        okAction: _logout,
        isCancel: true,
      );
    }
  }

  _delete() async {
    await injector.get<ApiClient>().deleteAccount();
    await injector.get<StorageService>().clear();
    GlobalValue.avatar = null;
    GlobalValue.id = null;
    GlobalValue.name = null;
    Navigator.of(context)
        .pushNamedAndRemoveUntil(RouterName.base_tabbar, (route) => false);
  }

  _logout() async {
    await injector.get<ApiClient>().logout();
    await injector.get<StorageService>().clear();
    GlobalValue.avatar = null;
    GlobalValue.id = null;
    GlobalValue.name = null;
    Navigator.of(context)
        .pushNamedAndRemoveUntil(RouterName.base_tabbar, (route) => false);
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
