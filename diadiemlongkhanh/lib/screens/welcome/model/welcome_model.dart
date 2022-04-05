import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeModel {
  Widget img;
  String? title;
  String subTitle;
  String description;

  WelcomeModel({
    required this.img,
    this.title,
    required this.subTitle,
    required this.description,
  });

  static final List<WelcomeModel> welcomeDatas = [
    WelcomeModel(
      img: Image.asset(
        ConstantImages.welcome1,
        width: 250,
        height: 194,
      ),
      title: 'Chào mừng bạn đến',
      subTitle: 'Địa Điểm Long Khánh',
      description:
          'Mong muốn mang lại những điều hữu ích, những trải \nnghiệm tốt đẹp khi đến Long Khánh - Đồng Nai',
    ),
    WelcomeModel(
      img: Image.asset(
        ConstantImages.welcome2,
        width: 321,
        height: 194,
      ),
      subTitle: 'Khám Phá',
      description:
          'Bạn có thể tìm kiếm mọi thứ các Địa Điểm ăn uống, \ndịch vụ, du lịch Long Khánh',
    ),
    WelcomeModel(
      img: Image.asset(
        ConstantImages.welcome3,
        width: 250,
        height: 194,
      ),
      subTitle: 'Tìm Quanh Đây',
      description:
          'Tìm kiếm dễ dàng với tính năng tìm quanh đây.\n(Có cần thêm nội dung cho hấp dẫn không?)',
    ),
  ];
}
