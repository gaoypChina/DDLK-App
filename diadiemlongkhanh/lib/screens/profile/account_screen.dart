import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/screens/new_feeds/widgets/new_feed_item_view.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: ColorConstant.grey_F2F4F8,
      appBar: MyAppBar(
        title: 'Thông tin cá nhân',
        isShowBackButton: false,
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(RouterName.setting),
            icon: SvgPicture.asset(
              ConstantIcons.ic_setting,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildInfoUserView(context),
            // _buildFollowView(context),
            Container(
              height: 112,
              child: Column(
                children: [
                  _buildOptionItemView(
                    'Địa điểm đã lưu',
                    SvgPicture.asset(
                      ConstantIcons.ic_bookmark_outline,
                    ),
                  ),
                  _buildOptionItemView(
                    'Khuyến mãi đã lưu',
                    Image.asset(
                      ConstantIcons.ic_discount,
                      height: 24,
                      width: 24,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 32,
                right: 16,
                left: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '50 ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        TextSpan(
                          text: 'Đánh giá',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Mới nhất',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      SvgPicture.asset(ConstantIcons.ic_chevron_down)
                    ],
                  )
                ],
              ),
            ),
            ListView.builder(
              itemCount: 10,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.only(
                top: 24,
                bottom: 30,
              ),
              itemBuilder: (BuildContext context, int index) {
                return NewFeedItemView(
                  isShowComment: true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Container _buildFollowView(BuildContext context) {
    return Container(
      height: 72,
      width: double.infinity,
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 24,
      ),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    ConstantIcons.ic_plus,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Theo dõi',
                    style: Theme.of(context).textTheme.headline4?.apply(
                          color: Theme.of(context).primaryColor,
                        ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 7,
          ),
          Container(
            width: 83,
            decoration: BoxDecoration(
              color: ColorConstant.neutral_gray_lightest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Liên hệ',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _buildInfoUserView(BuildContext context) {
    return Container(
      height: 265,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAvtView(context),
          Text(
            'Cris Evan',
            style: Theme.of(context).textTheme.headline3,
          ),
          Container(
            // height: 24,
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorConstant.neutral_gray_lightest,
            ),
            child: Text(
              'Ngày tham gia: 04/04/2022',
              style: TextStyle(
                fontSize: 12,
                color: ColorConstant.neutral_black,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildSummaryInfoView(
                      'Bài viết',
                      '50',
                    ),
                  ),
                  Expanded(
                    child: _buildSummaryInfoView(
                      'Người theo dõi',
                      '50',
                    ),
                  ),
                  Expanded(
                    child: _buildSummaryInfoView(
                      'Lượt thích',
                      '50',
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _buildOptionItemView(
    String title,
    Widget icon,
  ) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: ColorConstant.neutral_gray_lightest,
          ),
        ),
      ),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          SvgPicture.asset(
            ConstantIcons.ic_chevron_right,
            color: ColorConstant.neutral_black,
          ),
        ],
      ),
    );
  }

  Container _buildSummaryInfoView(
    String title,
    String subtitle,
  ) {
    return Container(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: ColorConstant.neutral_gray,
            ),
          ),
          SizedBox(height: 7),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }

  Container _buildAvtView(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 35,
        bottom: 4,
      ),
      height: 86,
      width: 78,
      child: Stack(
        children: [
          ClipRRectImage(
            radius: 39,
            url:
                'https://upload.wikimedia.org/wikipedia/commons/8/89/Chris_Evans_2020_%28cropped%29.jpg',
            width: 78,
            height: 78,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 16,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 11,
                    width: 11,
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: ColorConstant.orange_secondary,
                    ),
                    child: SvgPicture.asset(
                      ConstantIcons.ic_check,
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    'Đã xác minh',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
