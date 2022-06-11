import 'dart:convert';
import 'dart:io';

import 'package:diadiemlongkhanh/models/remote/place_response/place_response.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/screens/places/places_dialog.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/widgets/app_checkbox.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:diadiemlongkhanh/widgets/main_button.dart';
import 'package:diadiemlongkhanh/widgets/main_text_form_field.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:diadiemlongkhanh/widgets/my_rating_bar.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({
    Key? key,
    this.place,
  }) : super(key: key);
  final PlaceModel? place;
  @override
  _CreateReviewScreenState createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  double _position = 5;
  double _view = 5;
  double _foodDrink = 5;
  double _service = 5;
  double _price = 5;
  bool _isAnonymous = false;
  PlaceModel? _place;
  final _contentTextController = TextEditingController();
  final _titleTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<XFile> _imageFileList = [];

  @override
  void initState() {
    super.initState();
    _place = widget.place;
  }

  _pickImages() async {
    final ImagePicker _picker = ImagePicker();

    final List<XFile>? images = await _picker.pickMultiImage();
    print(images);
    if (images != null) {
      setState(() {
        _imageFileList = images;
      });
    }
  }

  _createReview() async {
    if (_place == null) {
      AppUtils.showOkDialog(context, 'Vui lòng chọn địa điểm');
      return;
    }
    if (_titleTextController.text == '') {
      AppUtils.showOkDialog(context, 'Vui lòng nhập tiêu đề');
      return;
    }
    if (_contentTextController.text == '') {
      AppUtils.showOkDialog(context, 'Vui lòng nhập nội dung');
      return;
    }
    if (_contentTextController.text.length < 10) {
      AppUtils.showOkDialog(
          context, 'Vui lòng nhập nội dung tối thiểu 10 ký tự');
      return;
    }
    AppUtils.showLoading();
    final data = {
      'ratePosition': _position,
      'rateView': _view,
      'rateDrink': _foodDrink,
      'rateService': _service,
      'ratePrice': _price,
      'anonymous': _isAnonymous,
      'title': _titleTextController.text,
      'content': _contentTextController.text,
      'place': _place!.id,
    };
    var form = FormData.fromMap(
      {
        'data': json.encode(data),
      },
    );

    for (int i = 0; i < _imageFileList.length; i++) {
      form.files.addAll([
        MapEntry(
          'files',
          MultipartFile.fromFileSync(
            _imageFileList[0].path,
            contentType:
                MediaType.parse(lookupMimeType(_imageFileList[0].path) ?? ''),
          ),
        )
      ]);
    }
    try {
      final res = await injector.get<ApiClient>().createReview(form);
      AppUtils.hideLoading();
      if (res != null) {
        AppUtils.showSuccessAlert(
          context,
          title: 'Tạo đánh giá địa điểm thành công',
          okTitle: 'Xác nhận',
          okAction: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        );
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Chọn địa điểm đánh giá',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            _place != null
                                ? GestureDetector(
                                    onTap: () => AppUtils.showBottomDialog(
                                      context,
                                      PlacesDialog(
                                        onSelect: (item) {
                                          setState(() {
                                            _place = item;
                                          });
                                        },
                                      ),
                                    ),
                                    child: Text(
                                      'Thay đổi',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink()
                          ],
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
                          'Tiêu đề đánh giá',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        MainTextFormField(
                          maxLines: 1,
                          controller: _titleTextController,
                          contentPadding: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            left: 16,
                          ),
                        ),
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
                            controller: _contentTextController,
                            hintText: 'Tối thiểu 10 ký tự',
                            contentPadding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              left: 16,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          children: [
                            AppCheckbox(
                              value: _isAnonymous,
                              onChanged: (val) {
                                setState(() {
                                  _isAnonymous = !_isAnonymous;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Đánh giá ẩn danh',
                              style: Theme.of(context).textTheme.headline4,
                            )
                          ],
                        ),
                        MainButton(
                          margin: const EdgeInsets.only(top: 48),
                          title: 'Gửi đánh giá',
                          onPressed: _createReview,
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
      ),
    );
  }

  Widget _buildUploadImageView() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      height: 76,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: _imageFileList.length + 1,
        itemBuilder: (_, index) {
          if (index > 0) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.file(
                      File(_imageFileList[index - 1].path),
                      width: 76,
                      height: 76,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _imageFileList.removeAt(index - 1);
                        });
                      },
                      child: Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.close,
                            size: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: _pickImages,
              child: DottedBorder(
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
              rating: _position,
              onRatingUpdate: (rate, isEmpty) {
                setState(() {
                  if (!isEmpty && rate > 1) {
                    _position = rate - 1;
                  } else {
                    _position = rate.toDouble();
                  }
                });
              },
            ),
            _buildListRatingView(
              '2. Không gian',
              rating: _view,
              onRatingUpdate: (rate, isEmpty) {
                setState(() {
                  if (!isEmpty && rate > 1) {
                    _view = rate - 1;
                  } else {
                    _view = rate.toDouble();
                  }
                });
              },
            ),
            _buildListRatingView(
              '3. Ăn uống',
              rating: _foodDrink,
              onRatingUpdate: (rate, isEmpty) {
                setState(() {
                  if (!isEmpty && rate > 1) {
                    _foodDrink = rate - 1;
                  } else {
                    _foodDrink = rate.toDouble();
                  }
                });
              },
            ),
            _buildListRatingView(
              '4. Dịch vụ',
              rating: _service,
              onRatingUpdate: (rate, isEmpty) {
                setState(() {
                  if (!isEmpty && rate > 1) {
                    _service = rate - 1;
                  } else {
                    _service = rate.toDouble();
                  }
                });
              },
            ),
            _buildListRatingView(
              '5. Giá cả',
              rating: _price,
              isBottomLine: false,
              onRatingUpdate: (rate, isEmpty) {
                setState(() {
                  if (!isEmpty && rate > 1) {
                    _price = rate - 1;
                  } else {
                    _price = rate.toDouble();
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Container _buildListRatingView(
    String title, {
    double rating = 1,
    bool isBottomLine = true,
    required Function(int, bool) onRatingUpdate,
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
                  _getEmotion(rating.round()),
                  width: 32,
                  height: 32,
                )
              ],
            ),
          ),
          MyRatingBar(
            rating: rating,
            onRatingUpdate: onRatingUpdate,
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
        AppUtils.showBottomDialog(
          context,
          PlacesDialog(
            onSelect: (item) {
              setState(() {
                _place = item;
              });
            },
          ),
        );
      },
      child: _place != null
          ? _buildInfoView(context)
          : DottedBorder(
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

  Widget _buildInfoView(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // injector.get<StorageService>().savePlaceIds(item?.place?.id ?? '');
        // Navigator.of(context)
        //     .pushNamed(RouterName.detail_place, arguments: item?.place?.id);
      },
      child: Container(
        height: 82,
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
                _place?.avatar?.path ?? '',
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
                  Text(
                    _place?.name ?? '',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        ConstantIcons.ic_marker_grey,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          _place!.address?.specific ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10,
                              color: ColorConstant.neutral_gray_lighter),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  // Row(
                  //   children: [
                  //     Text(
                  //       AppUtils.roundedRating(item!.place?.avgRate ?? 0)
                  //           .toString(),
                  //       style: TextStyle(
                  //         fontSize: 10,
                  //         fontWeight: FontWeight.w500,
                  //         color: ColorConstant.neutral_gray_lighter,
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 7,
                  //     ),
                  //     MyRatingBar(
                  //       rating: item!.place?.avgRate ?? 0,
                  //       onRatingUpdate: (rate, isEmpty) {},
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
