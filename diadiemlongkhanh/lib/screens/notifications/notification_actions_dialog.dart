import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotificationActionsDialog extends StatelessWidget {
  const NotificationActionsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Container(
              height: 178,
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
                          color: ColorConstant.neutral_gray_lightest,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Thêm',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: SvgPicture.asset(
                            ConstantIcons.ic_close,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildActionItem(
                    context,
                    ConstantIcons.ic_check_circle,
                    'Đánh dấu đã đọc tất cả',
                  ),
                  Divider(
                    height: 1,
                    color: ColorConstant.neutral_gray_lightest,
                    indent: 16,
                    endIndent: 16,
                  ),
                  _buildActionItem(
                    context,
                    ConstantIcons.ic_bin,
                    'Xóa tất cả',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionItem(
    BuildContext context,
    String icon,
    String title,
  ) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText2,
          )
        ],
      ),
    );
  }
}
