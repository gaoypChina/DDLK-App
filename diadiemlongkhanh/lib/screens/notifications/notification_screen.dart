import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/screens/notifications/notification_actions_dialog.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.grey_F2F4F8,
      appBar: MyAppBar(
        title: 'Thông báo',
        actions: [
          IconButton(
            onPressed: () => AppUtils.showBottomDialog(
              context,
              NotificationActionsDialog(),
            ),
            icon: Icon(
              Icons.more_horiz,
              color: ColorConstant.neutral_black,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 24,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTabItem('Tất cả (12)', 0),
                _buildTabItem('Thông báo mới (3)', 1),
                _buildTabItem('Đã đọc (9)', 2),
              ],
            ),
          ),
          Expanded(
            child: _buildListNotiView(context),
          )
        ],
      ),
    );
  }

  ListView _buildListNotiView(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      itemBuilder: (_, index) {
        return InkWell(
          onTap: () => Navigator.of(context).pushNamed(
            RouterName.detail_notification,
          ),
          child: Container(
            height: 96,
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.only(
              left: 12,
              right: 9,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 8),
                  blurRadius: 20,
                  color: ColorConstant.neutral_black.withOpacity(0.12),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRectImage(
                  height: 72,
                  width: 72,
                  radius: 4,
                  url:
                      'https://static.hotdeal.vn/images/1532/1531992/60x60/349432-king-bbq-menu-329k-buffet-nuong-lau-dang-cap-vua-nuong-han-quoc.jpg',
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 18,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstant.neutral_gray_lightest,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Text(
                          'Địa điểm mới',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: ColorConstant.neutral_gray,
                          ),
                        ),
                      ),
                      Text(
                        'Mono Coffee đã có mặt tại Long Khánh',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(height: 1.7),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '1 giờ',
                        style: TextStyle(
                          fontSize: 10,
                          color: ColorConstant.neutral_gray,
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    ConstantImages.new_tag,
                    width: 48,
                    height: 27,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabItem(String title, int index) {
    return Container(
      height: 28,
      padding: const EdgeInsets.only(
        left: 20,
        right: 14,
        top: 6,
      ),
      decoration: BoxDecoration(
        color: index == _currentIndex
            ? ColorConstant.green_D5F4D9
            : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight:
              index == _currentIndex ? FontWeight.w500 : FontWeight.w400,
          color: index == _currentIndex
              ? Theme.of(context).primaryColor
              : ColorConstant.neutral_gray,
        ),
      ),
    );
  }
}
