import 'package:diadiemlongkhanh/models/remote/comment/comment_response.dart';
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

class NewFeedItemView extends StatelessWidget {
  final bool isShowComment;
  final Function()? nextToDetail;
  final NewFeedModel? item;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;
  final List<CommentModel>? comments;
  NewFeedItemView({
    this.isShowComment = false,
    this.nextToDetail,
    this.item,
    this.margin,
    this.decoration,
    this.comments,
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
      margin: margin != null
          ? margin
          : const EdgeInsets.only(
              bottom: 16,
              left: 16,
              right: 16,
            ),
      decoration: decoration != null
          ? decoration
          : BoxDecoration(
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
            item!.content ?? '',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          _buildPhotosView(context),
          _buildInfoView(context),
          _buildBehaviorView(),
          SizedBox(
            height: 16,
          ),
          _buildInputCommentField(),
          comments != null ? _buildListCommentView(context) : SizedBox.shrink(),
          // SizedBox(
          //   height: (item!.commentCount ?? 0) > 0 ? 24 : 0,
          // ),
          // (item!.commentCount ?? 0) > 0
          //     ? Center(
          //         child: Text(
          //           'Xem tất cả ${item!.commentCount ?? 0} bình luận',
          //           style: Theme.of(context).textTheme.headline2,
          //         ),
          //       )
          //     : SizedBox.shrink()
        ],
      ),
    );
  }

  ListView _buildListCommentView(BuildContext context) {
    final _comments = comments ?? [];
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: _comments.length,
      padding: const EdgeInsets.only(
        top: 16,
      ),
      shrinkWrap: true,
      itemBuilder: (_, index) {
        final item = _comments[index];
        return Padding(
          padding: const EdgeInsets.only(
            bottom: 18,
          ),
          child: Row(
            children: [
              ClipRRectImage(
                radius: 18,
                url: AppUtils.getUrlImage(
                  item.author?.avatar ?? '',
                  width: 36,
                  height: 36,
                ),
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
                            item.author?.name ?? '',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            item.content ?? '',
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
                          AppUtils.convertDatetimePrefix(item.createdAt ?? ''),
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
              SvgPicture.asset(
                item!.isLiked
                    ? ConstantIcons.ic_heart
                    : ConstantIcons.ic_heart_outline,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '${item!.likeCount ?? 0} Thích',
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
          GestureDetector(
            onTap: nextToDetail,
            child: Row(
              children: [
                SvgPicture.asset(ConstantIcons.ic_comment),
                SizedBox(
                  width: 6,
                ),
                Text(
                  '${item!.commentCount ?? 0} Bình luận',
                  style: TextStyle(
                    fontSize: 10,
                    color: ColorConstant.neutral_gray,
                  ),
                )
              ],
            ),
          ),
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
            url: AppUtils.getUrlImage(
              item!.place?.avatar?.path ?? '',
              width: 64,
              height: 64,
            ),
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
                        item!.place?.name ?? '',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      AppUtils.getDistance(item!.place?.distance ?? 0) > 0
                          ? 'Cách ${AppUtils.getDistance(item!.place?.distance ?? 0)}km '
                          : '',
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
                      item!.place?.address?.specific ?? '',
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
                      AppUtils.roundedRating(item!.place?.avgRate ?? 0)
                          .toString(),
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
                      rating: item!.place?.avgRate ?? 0,
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

  Widget _buildDoublePhotoView(
    BuildContext context,
    List<ThumbnailModel> images,
  ) {
    return Row(
      children: [
        Expanded(
          child: ClipRRectImage(
            radius: 8,
            url: AppUtils.getUrlImage(
              images.first.path ?? '',
            ),
            height: double.infinity,
            onPressed: () => AppUtils.showBottomDialog(
              context,
              FullImageView(
                AppUtils.getUrlImage(
                  images.first.path ?? '',
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: ClipRRectImage(
            radius: 8,
            url: AppUtils.getUrlImage(
              images.last.path ?? '',
            ),
            height: double.infinity,
            onPressed: () => AppUtils.showBottomDialog(
              context,
              FullImageView(
                AppUtils.getUrlImage(
                  images.last.path ?? '',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildThreePhotoView(
    BuildContext context,
    List<ThumbnailModel> images,
  ) {
    return Row(
      children: [
        Expanded(
          child: ClipRRectImage(
            radius: 8,
            url: AppUtils.getUrlImage(
              images.first.path ?? '',
            ),
            height: double.infinity,
            onPressed: () => AppUtils.showBottomDialog(
              context,
              FullImageView(
                AppUtils.getUrlImage(
                  images.first.path ?? '',
                ),
              ),
            ),
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
                  url: AppUtils.getUrlImage(
                    images[1].path ?? '',
                  ),
                  width: double.infinity,
                  onPressed: () => AppUtils.showBottomDialog(
                    context,
                    FullImageView(
                      AppUtils.getUrlImage(
                        images[1].path ?? '',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: ClipRRectImage(
                  radius: 8,
                  url: AppUtils.getUrlImage(
                    images.last.path ?? '',
                  ),
                  width: double.infinity,
                  onPressed: () => AppUtils.showBottomDialog(
                    context,
                    FullImageView(
                      AppUtils.getUrlImage(
                        images.last.path ?? '',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFourPhotoView(
    BuildContext context,
    List<ThumbnailModel> images, {
    bool isMulti = false,
  }) {
    return Column(
      children: [
        Expanded(
          child: ClipRRectImage(
            radius: 8,
            url: AppUtils.getUrlImage(
              images.first.path ?? '',
            ),
            width: double.infinity,
            height: double.infinity,
            onPressed: () => AppUtils.showBottomDialog(
              context,
              FullImageView(
                AppUtils.getUrlImage(
                  images.first.path ?? '',
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Expanded(
            child: Row(
          children: [
            Expanded(
              child: ClipRRectImage(
                radius: 8,
                url: AppUtils.getUrlImage(
                  images[1].path ?? '',
                ),
                height: double.infinity,
                onPressed: () => AppUtils.showBottomDialog(
                  context,
                  FullImageView(
                    AppUtils.getUrlImage(
                      images[1].path ?? '',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: ClipRRectImage(
                radius: 8,
                url: AppUtils.getUrlImage(
                  images[2].path ?? '',
                ),
                height: double.infinity,
                onPressed: () => AppUtils.showBottomDialog(
                  context,
                  FullImageView(
                    AppUtils.getUrlImage(
                      images[2].path ?? '',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Stack(
                children: [
                  ClipRRectImage(
                    radius: 8,
                    url: AppUtils.getUrlImage(
                      images[3].path ?? '',
                    ),
                    height: double.infinity,
                  ),
                  isMulti
                      ? Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              '+5',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        )
                      : SizedBox.shrink()
                ],
              ),
            ),
          ],
        ))
      ],
    );
  }

  Container _buildPhotosView(BuildContext context) {
    final images = item!.images;
    Widget photoView = SizedBox.shrink();
    switch (images.length) {
      case 1:
        photoView = ClipRRectImage(
          radius: 8,
          url: AppUtils.getUrlImage(
            images.first.path ?? '',
          ),
          width: double.infinity,
          height: double.infinity,
          onPressed: () => AppUtils.showBottomDialog(
            context,
            FullImageView(
              AppUtils.getUrlImage(
                images.first.path ?? '',
              ),
            ),
          ),
        );
        break;
      case 2:
        photoView = _buildDoublePhotoView(context, images);
        break;
      case 3:
        photoView = _buildThreePhotoView(context, images);
        break;
      case 4:
        photoView = _buildFourPhotoView(context, images);
        break;
      default:
        photoView = _buildFourPhotoView(
          context,
          images,
          isMulti: true,
        );
    }
    return Container(
      height: 218,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 12),
      child: photoView,
    );
  }

  Row _buildHeaderView(BuildContext context) {
    return Row(
      children: [
        ClipRRectImage(
          radius: 22,
          url: AppUtils.getUrlImage(
            item!.author?.avatar ?? '',
            width: 44,
            height: 44,
          ),
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
                    item!.author?.name ?? '',
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
                      item!.place?.name ?? '',
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
                    AppUtils.roundedRating(item!.rateAvg ?? 0).toString(),
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
                    rating: item!.rateAvg ?? 0,
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
                    AppUtils.convertDatetimePrefix(item!.createdAt ?? ''),
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
      width: 24,
      child: Icon(Icons.more_horiz),
    );
  }
}
