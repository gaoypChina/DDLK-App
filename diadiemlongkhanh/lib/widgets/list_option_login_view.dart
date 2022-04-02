import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ListOptionLoginView extends StatelessWidget {
  final bool isLogin;
  ListOptionLoginView({this.isLogin = true});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildOptionButton(
          context,
          icon: SvgPicture.asset(
            ConstantIcons.ic_user,
          ),
          title: 'Sử dụng số điện thoại hoặc email',
          onPressed: () => Navigator.of(context).pushNamed(RouterName.login),
        ),
        SizedBox(
          height: 16,
        ),
        _buildOptionButton(
          context,
          icon: SvgPicture.asset(
            ConstantIcons.ic_fb,
          ),
          title: 'Tiếp tục với Facebook',
        ),
        SizedBox(
          height: 16,
        ),
        _buildOptionButton(
          context,
          icon: SvgPicture.asset(
            ConstantIcons.ic_gg,
          ),
          title: 'Tiếp tục với Google',
        ),
        SizedBox(
          height: 16,
        ),
        _buildOptionButton(
          context,
          icon: SvgPicture.asset(
            ConstantIcons.ic_apple,
          ),
          title: 'Tiếp tục với Apple',
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _buildOptionButton(BuildContext context,
      {required Widget icon, required String title, Function()? onPressed}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Container(
        height: 48,
        padding: const EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: ColorConstant.border_gray,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon,
            Text(
              title,
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              width: 40,
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
