import 'package:diadiemlongkhanh/models/remote/user/user_response.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/widgets/line_dashed_painter.dart';
import 'package:diadiemlongkhanh/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoContactDialog extends StatelessWidget {
  const InfoContactDialog({
    Key? key,
    required this.user,
  }) : super(key: key);
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.6),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: ColorConstant.neutral_gray_lightest),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Thông tin liên hệ',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: SvgPicture.asset(ConstantIcons.ic_close),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          _buildItemContact(
                            context,
                            ConstantIcons.ic_fb,
                            user.social?.facebook ?? 'Chưa cập nhật',
                          ),
                          _buildItemContact(
                            context,
                            ConstantIcons.ic_instagram,
                            user.social?.instagram ?? 'Chưa cập nhật',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 85,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: ColorConstant.neutral_gray_lightest,
                        ),
                      ),
                    ),
                    child: MainButton(
                      onPressed: () {
                        if (user.phone == null) {
                          AppUtils.showOkDialog(
                            context,
                            'Chưa cập nhật số điện thoại',
                          );
                          return;
                        }
                        makePhoneCall();
                      },
                      title: 'Gọi điện',
                      icon: SvgPicture.asset(ConstantIcons.ic_phone),
                      margin: const EdgeInsets.only(
                        top: 16,
                        right: 16,
                        left: 16,
                        bottom: 21,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: user.phone!,
    );
    await launchUrl(launchUri);
  }

  Widget _buildItemContact(
    BuildContext context,
    String icon,
    String value,
  ) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (value == 'Chưa cập nhật') {
          return;
        }
        AppUtils.launchLink(value);
      },
      child: Container(
        height: 48,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                SvgPicture.asset(icon),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle1?.apply(
                          decoration: value != 'Chưa cập nhật'
                              ? TextDecoration.underline
                              : TextDecoration.none,
                        ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              child: CustomPaint(
                painter: LineDashedPainter(
                  isHorizontal: false,
                  color: ColorConstant.border_gray,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
