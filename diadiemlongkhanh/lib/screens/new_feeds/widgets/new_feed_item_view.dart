import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:diadiemlongkhanh/widgets/main_text_form_field.dart';
import 'package:diadiemlongkhanh/widgets/my_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NewFeedItemView extends StatelessWidget {
  final bool isShowComment;
  NewFeedItemView({
    this.isShowComment = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 12,
        left: 12,
        right: 12,
        bottom: 16,
      ),
      margin: const EdgeInsets.only(
        bottom: 16,
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.grey_shadow.withOpacity(0.12),
            offset: Offset(0, 12),
            blurRadius: 40,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderView(context),
          SizedBox(
            height: 8,
          ),
          Text(
            'View đẹp, menu giá phải chăng',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          _buildPhotosView(),
          _buildInfoView(context),
          _buildBehaviorView(),
          SizedBox(
            height: 16,
          ),
          _buildInputCommentField(),
          isShowComment ? _buildListCommentView(context) : SizedBox.shrink(),
          SizedBox(
            height: 24,
          ),
          Center(
            child: Text(
              'Xem tất cả 10 bình luận',
              style: Theme.of(context).textTheme.headline2,
            ),
          )
        ],
      ),
    );
  }

  ListView _buildListCommentView(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      padding: const EdgeInsets.only(
        top: 16,
      ),
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.only(
            bottom: 18,
          ),
          child: Row(
            children: [
              ClipRRectImage(
                radius: 18,
                url:
                    'https://bangsport.net/wp-content/uploads/2021/12/3139455-64344828-2560-1440.jpg',
                width: 36,
                height: 36,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 12,
                        right: 12,
                        bottom: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: ColorConstant.neutral_gray_lightest,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bửu Quang',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Địa điểm xịn ghê, bữa nào mình phải ghé thăm mới được',
                            maxLines: null,
                            style: TextStyle(
                              fontSize: 12,
                              color: ColorConstant.neutral_black,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          '7 ngày trước',
                          style: TextStyle(
                            fontSize: 10,
                            color: ColorConstant.neutral_gray,
                          ),
                        ),
                        SizedBox(
                          width: 17,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              ConstantIcons.ic_heart_outline,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '6 Thích',
                              style: TextStyle(
                                fontSize: 10,
                                color: ColorConstant.neutral_gray,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          'Trả lời',
                          style: TextStyle(
                            fontSize: 10,
                            color: ColorConstant.neutral_gray,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Row _buildInputCommentField() {
    return Row(
      children: [
        ClipRRectImage(
          radius: 18,
          url:
              'https://upload.wikimedia.org/wikipedia/commons/8/89/Chris_Evans_2020_%28cropped%29.jpg',
          width: 36,
          height: 36,
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: SizedBox(
            height: 36,
            child: MainTextFormField(
              hintText: 'Viết bình luận',
              colorBorder: ColorConstant.neutral_gray_lightest,
              radius: 18,
            ),
          ),
        ),
        SvgPicture.asset(
          ConstantIcons.ic_send,
        )
      ],
    );
  }

  Container _buildBehaviorView() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ColorConstant.neutral_gray_lightest,
          ),
        ),
      ),
      child: Row(
        children: [
          Row(
            children: [
              SvgPicture.asset(ConstantIcons.ic_heart),
              SizedBox(
                width: 5,
              ),
              Text(
                '6 Thích',
                style: TextStyle(
                  fontSize: 10,
                  color: ColorConstant.neutral_gray,
                ),
              )
            ],
          ),
          SizedBox(
            width: 18,
          ),
          Row(
            children: [
              SvgPicture.asset(ConstantIcons.ic_comment),
              SizedBox(
                width: 6,
              ),
              Text(
                '10 Bình luận',
                style: TextStyle(
                  fontSize: 10,
                  color: ColorConstant.neutral_gray,
                ),
              )
            ],
          ),
          SizedBox(
            width: 18,
          ),
          Row(
            children: [
              SvgPicture.asset(ConstantIcons.ic_eye),
              SizedBox(
                width: 4,
              ),
              Text(
                '10 Lượt xem',
                style: TextStyle(
                  fontSize: 10,
                  color: ColorConstant.neutral_gray,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Container _buildInfoView(BuildContext context) {
    return Container(
      height: 82,
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ColorConstant.neutral_gray_lightest,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
          ),
          BoxShadow(
            color: Colors.white,
            blurRadius: 16.0,
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRectImage(
            radius: 4,
            url:
                'https://bazantravel.com/cdn/medias/uploads/83/83316-pullman-vung-tau-700x466.jpg',
            width: 64,
            height: 64,
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Harleys The Coffee',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Cách 2km',
                      style: TextStyle(
                        fontSize: 10,
                        color: ColorConstant.neutral_gray,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      ConstantIcons.ic_marker_grey,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Phường Xuân An',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 10,
                          color: ColorConstant.neutral_gray_lighter),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Text(
                      '4.0',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: ColorConstant.neutral_gray_lighter,
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    MyRatingBar(
                      rating: 4,
                      onRatingUpdate: (rate, isEmpty) {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildPhotosView() {
    return Container(
      height: 218,
      margin: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Expanded(
            child: ClipRRectImage(
              radius: 8,
              url:
                  'https://bazantravel.com/cdn/medias/uploads/83/83316-pullman-vung-tau-700x466.jpg',
              height: double.infinity,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ClipRRectImage(
                    radius: 8,
                    url:
                        'https://bazantravel.com/cdn/medias/uploads/83/83316-pullman-vung-tau-700x466.jpg',
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: ClipRRectImage(
                    radius: 8,
                    url:
                        'https://bazantravel.com/cdn/medias/uploads/83/83316-pullman-vung-tau-700x466.jpg',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _buildHeaderView(BuildContext context) {
    return Row(
      children: [
        ClipRRectImage(
          radius: 22,
          url:
              'https://upload.wikimedia.org/wikipedia/commons/8/89/Chris_Evans_2020_%28cropped%29.jpg',
          width: 44,
          height: 44,
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Trần Tâm',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  SvgPicture.asset(
                    ConstantIcons.ic_right,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Flexible(
                    child: Text(
                      'Harleys The Coffee',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  Text(
                    '4.0',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.neutral_gray_lighter,
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  MyRatingBar(
                    rating: 4,
                    onRatingUpdate: (rate, isEmpty) {},
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 5,
                      right: 8,
                    ),
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(
                      color: ColorConstant.neutral_gray_lighter,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Text(
                    '7 ngày trước',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.neutral_gray_lighter,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        _buildFollowButton(context),
      ],
    );
  }

  Container _buildFollowButton(BuildContext context) {
    return Container(
      height: 24,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
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
            width: 12,
            height: 12,
          ),
          Text(
            'Theo dõi',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
