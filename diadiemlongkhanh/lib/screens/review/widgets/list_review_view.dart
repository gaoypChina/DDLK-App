import 'package:diadiemlongkhanh/models/remote/new_feed/new_feed_response.dart';
import 'package:diadiemlongkhanh/models/remote/thumnail/thumbnail_model.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:diadiemlongkhanh/widgets/full_image_view.dart';
import 'package:diadiemlongkhanh/widgets/main_text_form_field.dart';
import 'package:diadiemlongkhanh/widgets/my_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ListReviewView extends StatelessWidget {
  final EdgeInsets? padding;
  final List<NewFeedModel> reviews;
  ListReviewView({
    this.padding,
    required this.reviews,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reviews.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: padding,
      itemBuilder: (_, index) {
        final item = reviews[index];
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
              _buildHeaderInfoView(
                context,
                item,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                item.content ?? '',
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              item.images.isEmpty
                  ? SizedBox.shrink()
                  : _buildListPictureView(
                      context,
                      item.images,
                    ),
              _buildBehaviorView(item),
              SizedBox(
                height: 16,
              ),
              _buildInputCommentField(),
              // SizedBox(
              //   height: 24,
              // ),
              // Center(
              //   child: Text(
              //     'Xem tất cả 10 bình luận',
              //     style: Theme.of(context).textTheme.headline2,
              //   ),
              // )
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

  Container _buildBehaviorView(NewFeedModel item) {
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
                '${item.likeCount} Thích',
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
                '${item.commentCount} Bình luận',
                style: TextStyle(
                  fontSize: 10,
                  color: ColorConstant.neutral_gray,
                ),
              )
            ],
          ),
          // SizedBox(
          //   width: 18,
          // ),
          // Row(
          //   children: [
          //     SvgPicture.asset(ConstantIcons.ic_eye),
          //     SizedBox(
          //       width: 4,
          //     ),
          //     Text(
          //       '10 Lượt xem',
          //       style: TextStyle(
          //         fontSize: 10,
          //         color: ColorConstant.neutral_gray,
          //       ),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }

  Container _buildListPictureView(
    BuildContext context,
    List<ThumbnailModel> photos,
  ) {
    return Container(
      height: 72,
      margin: const EdgeInsets.only(top: 12),
      child: ListView.builder(
        itemCount: photos.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          final item = photos[index];
          return Container(
            height: 72,
            width: 72,
            margin: const EdgeInsets.only(right: 8),
            child: Stack(
              children: [
                ClipRRectImage(
                  height: 72,
                  width: 72,
                  onPressed: () => AppUtils.showBottomDialog(
                    context,
                    FullImageView(
                      AppUtils.getUrlImage(
                        item.path ?? '',
                      ),
                    ),
                  ),
                  url: AppUtils.getUrlImage(
                    item.path ?? '',
                    width: 72,
                    height: 72,
                  ),
                  radius: 8,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Row _buildHeaderInfoView(
    BuildContext context,
    NewFeedModel item,
  ) {
    return Row(
      children: [
        ClipRRectImage(
          radius: 22,
          url: AppUtils.getUrlImage(item.author?.avatar ?? '',
              width: 44, height: 44),
          width: 44,
          height: 44,
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.author?.name ?? '',
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  Text(
                    AppUtils.roundedRating(item.rateAvg ?? 0).toString(),
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
                    rating: item.rateAvg ?? 0,
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
                    AppUtils.convertDatetimePrefix(item.createdAt ?? ''),
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
