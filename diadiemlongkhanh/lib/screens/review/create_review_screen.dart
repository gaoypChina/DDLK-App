import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/screens/places/places_dialog.dart';
import 'package:diadiemlongkhanh/widgets/main_button.dart';
import 'package:diadiemlongkhanh/widgets/main_text_form_field.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:diadiemlongkhanh/widgets/my_rating_bar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({Key? key}) : super(key: key);

  @override
  _CreateReviewScreenState createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.grey_F2F4F8,
      appBar: MyAppBar(
        title: 'Viết đánh giá',
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 67,
              left: 16,
              right: 16,
              bottom: 10,
              child: Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 66,
                  bottom: 42,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chọn địa điểm đánh giá',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      _buildPlaceSelectionView(),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        'Xếp hạng của bạn về địa điểm',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      _buildRatingView(),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        'Thêm hình ảnh',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      _buildUploadImageView(),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        'Nội dung đánh giá',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Container(
                        height: 94,
                        margin: const EdgeInsets.only(top: 8),
                        child: MainTextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                        ),
                      ),
                      MainButton(
                        margin: const EdgeInsets.only(top: 48),
                        title: 'Gửi đánh giá',
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 17),
                child: Image.asset(
                  ConstantImages.star_header,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildUploadImageView() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      height: 76,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 1,
        itemBuilder: (_, index) {
          return DottedBorder(
            radius: Radius.circular(4),
            borderType: BorderType.RRect,
            color: ColorConstant.border_gray,
            dashPattern: [6, 3],
            padding: const EdgeInsets.all(0),
            child: Container(
              height: 76,
              width: 76,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: ColorConstant.neutral_gray_lightest,
              ),
              child: Center(
                child: SvgPicture.asset(
                  ConstantIcons.ic_upload_img,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  DottedBorder _buildRatingView() {
    return DottedBorder(
      radius: Radius.circular(4),
      borderType: BorderType.RRect,
      color: ColorConstant.border_gray,
      dashPattern: [6, 3],
      padding: const EdgeInsets.all(0),
      child: Container(
        child: Column(
          children: [
            _buildListRatingView(
              '1. Vị trí',
              rating: 1,
            ),
            _buildListRatingView(
              '2. Không gian',
              rating: 2,
            ),
            _buildListRatingView(
              '3. Ăn uống',
              rating: 3,
            ),
            _buildListRatingView(
              '4. Dịch vụ',
              rating: 4,
            ),
            _buildListRatingView(
              '5. Giá cả',
              rating: 5,
              isBottomLine: false,
            ),
          ],
        ),
      ),
    );
  }

  Container _buildListRatingView(
    String title, {
    int rating = 1,
    bool isBottomLine = true,
  }) {
    return Container(
      height: 112,
      width: double.infinity,
      decoration: BoxDecoration(
        border: isBottomLine
            ? Border(
                bottom: BorderSide(
                  color: ColorConstant.neutral_gray_lightest,
                ),
              )
            : null,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
              right: 16,
              left: 16,
              bottom: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Image.asset(
                  _getEmotion(rating),
                  width: 32,
                  height: 32,
                )
              ],
            ),
          ),
          MyRatingBar(
            rating: rating,
            onRatingUpdate: (rate, isEmpty) {},
            emptyStar: SvgPicture.asset(ConstantIcons.ic_big_empty_star),
            fillStar: SvgPicture.asset(ConstantIcons.ic_big_fill_star),
          )
        ],
      ),
    );
  }

  String _getEmotion(int rating) {
    switch (rating) {
      case 1:
        return ConstantIcons.ic_very_bad;
      case 2:
        return ConstantIcons.ic_bad;
      case 3:
        return ConstantIcons.ic_not_good;
      case 4:
        return ConstantIcons.ic_good;
      case 5:
        return ConstantIcons.ic_very_good;
    }
    return '';
  }

  Widget _buildPlaceSelectionView() {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => PlacesDialog(),
        );
      },
      child: DottedBorder(
        radius: Radius.circular(4),
        borderType: BorderType.RRect,
        color: ColorConstant.border_gray,
        dashPattern: [6, 3],
        padding: const EdgeInsets.all(0),
        child: Container(
          height: 76,
          color: ColorConstant.neutral_gray_lightest,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                ConstantIcons.ic_map_pin,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Bấm để chọn địa điểm',
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
