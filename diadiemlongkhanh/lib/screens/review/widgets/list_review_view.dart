import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:diadiemlongkhanh/widgets/main_text_form_field.dart';
import 'package:diadiemlongkhanh/widgets/my_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ListReviewView extends StatelessWidget {
  final EdgeInsets? padding;
  ListReviewView({this.padding});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: padding,
      itemBuilder: (_, index) {
        return Container(
          margin: const EdgeInsets.only(
            bottom: 16,
            right: 16,
            left: 16,
          ),
          padding: const EdgeInsets.only(
            top: 16,
            left: 12,
            right: 12,
            bottom: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 15),
                blurRadius: 40,
                color: ColorConstant.grey_shadow.withOpacity(0.12),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderInfoView(context),
              SizedBox(
                height: 8,
              ),
              Text(
                'View đẹp, menu giá phải chăng',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              _buildListPictureView(),
              _buildBehaviorView(),
              SizedBox(
                height: 16,
              ),
              _buildInputCommentField(),
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

  Container _buildListPictureView() {
    return Container(
      height: 72,
      margin: const EdgeInsets.only(top: 12),
      child: ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return Container(
            height: 72,
            width: 72,
            margin: const EdgeInsets.only(right: 8),
            child: Stack(
              children: [
                ClipRRectImage(
                  height: 72,
                  width: 72,
                  url:
                      'https://vuakhuyenmai.vn/wp-content/uploads/highlands-khuyen-mai-30off-8-3-2022.jpg',
                  radius: 8,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Row _buildHeaderInfoView(BuildContext context) {
    return Row(
      children: [
        ClipRRectImage(
          radius: 22,
          url:
              'https://bangsport.net/wp-content/uploads/2021/12/3139455-64344828-2560-1440.jpg',
          width: 44,
          height: 44,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trần Tâm',
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  Text(
                    '4.0',
                    style: TextStyle(
                      fontSize: 12,
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
        )
      ],
    );
  }
}
