import 'package:flutter/material.dart';

class SettingMenuModel {
  Widget icon;
  String title;
  SettingMenuType type;
  SettingMenuModel(
    this.icon,
    this.title, {
    this.type = SettingMenuType.none,
  });
}

enum SettingMenuType {
  editProfile,
  changePassword,
  contact,
  settingProfile,
  none,
}
