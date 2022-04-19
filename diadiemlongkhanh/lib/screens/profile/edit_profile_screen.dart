import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:diadiemlongkhanh/widgets/main_button.dart';
import 'package:diadiemlongkhanh/widgets/main_text_form_field.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.grey_F2F4F8,
      appBar: MyAppBar(
        title: 'Cập nhật thông tin',
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 100,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildAvtView(),
                    _buildInfoView(context),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              child: SafeArea(
                child: Container(
                  height: 80,
                  color: Colors.white,
                  child: Center(
                    child: MainButton(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      title: 'Cập nhật tài khoản',
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _buildInfoView(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 15),
            blurRadius: 40,
            color: ColorConstant.grey_shadow.withOpacity(0.12),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông tin cá nhân',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 40,
            child: MainTextFormField(
              hintText: 'Nhập họ và tên',
            ),
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 40,
            child: MainTextFormField(
              hintText: '@tên người dùng',
            ),
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 40,
            child: MainTextFormField(
              hintText: 'email',
            ),
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 40,
            child: MainTextFormField(
              hintText: 'Ngày sinh',
              suffixIcon: SvgPicture.asset(
                ConstantIcons.ic_calendar,
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 40,
            child: MainTextFormField(
              hintText: 'Giới tính',
              suffixIcon: SvgPicture.asset(
                ConstantIcons.ic_expand_more,
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          _buildListSocialLink(context)
        ],
      ),
    );
  }

  Container _buildListSocialLink(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorConstant.neutral_gray_lightest,
      ),
      child: Column(
        children: [
          Container(
            height: 40,
            padding: const EdgeInsets.only(
              left: 16,
              right: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: ColorConstant.border_gray,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Thêm liên kết mạng xã hội',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SvgPicture.asset(
                  ConstantIcons.ic_expand_more,
                )
              ],
            ),
          ),
          _buildSocialItemView(),
          _buildSocialItemView(),
          _buildSocialItemView(),
        ],
      ),
    );
  }

  Container _buildSocialItemView() {
    return Container(
      height: 76,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 1,
            margin: const EdgeInsets.only(left: 16),
            color: ColorConstant.neutral_gray_lighter,
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 1,
                  color: ColorConstant.neutral_gray_lighter,
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: ColorConstant.border_gray,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildAvtView() {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 15),
            blurRadius: 40,
            color: ColorConstant.grey_shadow.withOpacity(0.12),
          )
        ],
      ),
      child: Center(
        child: Container(
          child: Stack(
            children: [
              ClipRRectImage(
                height: 78,
                width: 78,
                radius: 39,
                url:
                    'https://photo-cms-nghenhinvietnam.zadn.vn/Uploaded/trunghieu/2021_02_22/intro_1611166484_1__QZFD.jpg',
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white.withOpacity(
                      0.8,
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      ConstantIcons.ic_camera,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
