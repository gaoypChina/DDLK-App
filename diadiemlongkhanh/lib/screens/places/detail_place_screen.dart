import 'package:diadiemlongkhanh/models/local/local_social_model.dart';
import 'package:diadiemlongkhanh/models/remote/place_response/place_response.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/screens/places/bloc/detail_place_cubit.dart';
import 'package:diadiemlongkhanh/screens/places/widgets/all_opening_time_view.dart';
import 'package:diadiemlongkhanh/screens/places/widgets/full_name_content_place_view.dart';
import 'package:diadiemlongkhanh/screens/places/widgets/place_action_dialog.dart';
import 'package:diadiemlongkhanh/screens/review/widgets/list_review_view.dart';
import 'package:diadiemlongkhanh/screens/skeleton_view/shimmer_image.dart';
import 'package:diadiemlongkhanh/screens/skeleton_view/shimmer_paragraph.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:diadiemlongkhanh/widgets/full_image_view.dart';
import 'package:diadiemlongkhanh/widgets/line_dashed_painter.dart';
import 'package:diadiemlongkhanh/widgets/mini_map_view.dart';
import 'package:diadiemlongkhanh/widgets/my_back_button.dart';
import 'package:diadiemlongkhanh/widgets/my_rating_bar.dart';
import 'package:diadiemlongkhanh/widgets/verified_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailPlaceScreen extends StatefulWidget {
  const DetailPlaceScreen({Key? key}) : super(key: key);

  @override
  _DetailPlaceScreenState createState() => _DetailPlaceScreenState();
}

class _DetailPlaceScreenState extends State<DetailPlaceScreen> {
  ScrollController scrollController = new ScrollController();

  DetailPlaceCubit get _cubit => BlocProvider.of(context);
  List<String> tabMenu = [
    'Đánh giá địa điểm',
    'Thực đơn',
    'Bản đồ',
    'Thông tin liên hệ'
  ];
  double _heightInfoView = 620;
  double _heightPhoneView = 50;
  double _heightBenefitView = 100;
  double _heightRateView = 183;
  double _heightPriceView = 50;
  double _heightOpenTimeView = 116;
  double _heightMenuView = 144;
  double _heightMapView = 265;
  double _heightSliderView = 268;

  @override
  void initState() {
    super.initState();
    _handleListenerScroll();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _cubit.getDetail();
      _cubit.getReviews();
    });
  }

  _handleListenerScroll() {
    scrollController.addListener(() {
      if (scrollController.offset <= (_heightSliderView)) {
        if (!_cubit.isVisibleAppBar) {
          // print(scrollController.offset);
          _cubit.showAppBar(true);
          // setState(() {
          //   isVisibleAppBar = true;
          // });
        }
        if (_cubit.isVisible) {
          // _cubit.showMenu(false);
          // setState(() {
          //   isVisible = false;
          // });
        }
      } else {
        if (_cubit.isVisibleAppBar) {
          _cubit.showAppBar(false);
          // setState(() {
          //   isVisibleAppBar = false;
          // });
        }
        if (!_cubit.isVisible) {
          // _cubit.showMenu(true);
          // setState(() {
          //   isVisible = true;
          // });
        }
        // if (_cubit.isVisible) {
        //   if (scrollController.offset > _heightSliderView &&
        //       scrollController.offset <=
        //           _heightInfoView +
        //               16 +
        //               _heightPhoneView +
        //               16 +
        //               _heightBenefitView) {
        //     _cubit.selectMenu(0);
        //   } else if (scrollController.offset >
        //           _heightInfoView +
        //               16 +
        //               _heightPhoneView +
        //               16 +
        //               _heightBenefitView +
        //               16 +
        //               _heightRateView +
        //               16 +
        //               _heightPriceView +
        //               16 +
        //               _heightOpenTimeView &&
        //       scrollController.offset <=
        //           _heightInfoView +
        //               16 +
        //               _heightPhoneView +
        //               16 +
        //               _heightBenefitView +
        //               16 +
        //               _heightRateView +
        //               16 +
        //               _heightPriceView +
        //               16 +
        //               _heightOpenTimeView +
        //               16 +
        //               _heightMenuView) {
        //     _cubit.selectMenu(1);
        //   } else if (scrollController.offset >
        //           _heightInfoView +
        //               16 +
        //               _heightPhoneView +
        //               16 +
        //               _heightBenefitView +
        //               16 +
        //               _heightRateView +
        //               16 +
        //               _heightPriceView +
        //               16 +
        //               _heightOpenTimeView +
        //               16 +
        //               _heightMenuView &&
        //       scrollController.offset <=
        //           _heightInfoView +
        //               16 +
        //               _heightPhoneView +
        //               16 +
        //               _heightBenefitView +
        //               16 +
        //               _heightRateView +
        //               16 +
        //               _heightPriceView +
        //               16 +
        //               _heightOpenTimeView +
        //               16 +
        //               _heightMenuView +
        //               16 +
        //               _heightMapView) {
        //     _cubit.selectMenu(2);
        //   } else if (scrollController.offset >
        //       _heightInfoView +
        //           16 +
        //           _heightPhoneView +
        //           16 +
        //           _heightBenefitView +
        //           16 +
        //           _heightRateView +
        //           16 +
        //           _heightPriceView +
        //           16 +
        //           _heightOpenTimeView +
        //           16 +
        //           _heightMenuView +
        //           16 +
        //           _heightMapView) {
        //     _cubit.selectMenu(3);
        //   }
      }
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: ColorConstant.grey_F2F4F8,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              CustomScrollView(
                controller: scrollController,
                // shrinkWrap: true,
                slivers: <Widget>[
                  new SliverPadding(
                    padding: const EdgeInsets.all(0),
                    sliver: new SliverList(
                      delegate: new SliverChildListDelegate(
                        <Widget>[
                          _buildInfoDetailPlaceView(context),
                          BlocBuilder<DetailPlaceCubit, DetailPlaceState>(
                            buildWhen: (previous, current) =>
                                current is DetailPlaceGetReviewsDoneState,
                            builder: (_, state) {
                              return ListReviewView(
                                reviews: _cubit.reviews,
                                nextToDetail: (index) =>
                                    Navigator.of(context).pushNamed(
                                  RouterName.detail_review,
                                  arguments: _cubit.reviews[index],
                                ),
                                sendComment: (index) =>
                                    _cubit.sendComment(context, index),
                                likePost: (index) =>
                                    _cubit.likePost(context, index),
                                padding: const EdgeInsets.only(
                                  bottom: 60,
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              _buildAppBarView(context),
              _buildMenuTabView(context),
              Visibility(
                visible: !keyboardIsOpened,
                child: _buildRowButtonAction(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoDetailPlaceView(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<DetailPlaceCubit, DetailPlaceState>(
          buildWhen: (previous, current) =>
              current is DetailPlaceGetDoneState ||
              current is DetailPlaceChangePagePhotoState,
          builder: (context, state) {
            int currentIndex = 0;

            if (state is DetailPlaceChangePagePhotoState) {
              currentIndex = state.index;
            }
            return Container(
              height: 620,
              child: Stack(
                children: [
                  _buildSlider(
                    _cubit.place,
                    currentIndex,
                  ),
                  Positioned(
                    top: 248,
                    left: 0,
                    right: 0,
                    child: _buildInfoView(_cubit.place),
                  ),
                ],
              ),
            );
          },
        ),
        BlocBuilder<DetailPlaceCubit, DetailPlaceState>(
          buildWhen: (previous, current) => current is DetailPlaceGetDoneState,
          builder: (context, state) {
            return Column(
              children: [
                _buildContactView(),
                _buildConveniencesView(_cubit.place),
                _buildRatingView(_cubit.place),
                _buildRangePriceView(_cubit.place),
                _buildWorkHourView(_cubit.place),
                _buildMenuView(_cubit.place),
                _buildMapView(_cubit.place),
                _buildInfoContactView(_cubit.place),
                _buildSumarryReview(_cubit.place),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildRowButtonAction(BuildContext context) {
    return BlocBuilder<DetailPlaceCubit, DetailPlaceState>(
      buildWhen: (previous, current) =>
          current is DetailPlaceGetDoneState || current is DetailPlaceSaveState,
      builder: (_, state) {
        if (_cubit.place == null) {
          return SizedBox.shrink();
        }
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 56,
            width: 244,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  blurRadius: 32,
                  color: Theme.of(context).primaryColor.withOpacity(0.24),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _cubit.sharePlace(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        ConstantIcons.ic_share,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Chia sẻ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ColorConstant.neutral_black,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 39,
                ),
                GestureDetector(
                  onTap: () => _cubit.addReview(context),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor),
                    child: Center(
                      child: SvgPicture.asset(
                        ConstantIcons.ic_plus2,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 52,
                ),
                GestureDetector(
                  onTap: () => _cubit.savePlace(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        ConstantIcons.ic_book_mark,
                        color: _cubit.place!.isSaved
                            ? null
                            : ColorConstant.neutral_black,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        _cubit.place!.isSaved ? 'Bỏ lưu' : 'Lưu',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ColorConstant.neutral_black,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppBarView(BuildContext context) {
    return BlocBuilder<DetailPlaceCubit, DetailPlaceState>(
      buildWhen: (previous, current) => current is DetailPlaceShowAppBarState,
      builder: (context, state) {
        return Positioned(
          top: 12,
          left: 16,
          right: 16,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: _cubit.isVisibleAppBar ? 36.0 : 0.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.black.withOpacity(0.6),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          ConstantIcons.ic_chevron_left,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => AppUtils.showBottomDialog(
                      context,
                      PlaceActionDiaglog(
                        docId: _cubit.id,
                      ),
                    ),
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.black.withOpacity(0.6),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _selectTab(index) {
    double position = 0;
    if (index == 0) {
      position = _heightInfoView + 16 + _heightPhoneView + 16;
    } else if (index == 1) {
      position = _heightInfoView +
          16 +
          _heightPhoneView +
          16 +
          _heightBenefitView +
          16 +
          _heightRateView +
          16 +
          _heightPriceView +
          16 +
          _heightOpenTimeView;
    } else if (index == 2) {
      position = _heightInfoView +
          16 +
          _heightPhoneView +
          16 +
          _heightBenefitView +
          16 +
          _heightRateView +
          16 +
          _heightPriceView +
          16 +
          _heightOpenTimeView +
          16 +
          _heightMenuView;
    } else if (index == 3) {
      position = _heightInfoView +
          16 +
          _heightPhoneView +
          16 +
          _heightBenefitView +
          16 +
          _heightRateView +
          16 +
          _heightPriceView +
          16 +
          _heightOpenTimeView +
          16 +
          _heightMenuView +
          16 +
          _heightMapView;
    }
    scrollController.animateTo(
      position,
      duration: Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  Widget _buildMenuTabView(BuildContext context) {
    return BlocBuilder<DetailPlaceCubit, DetailPlaceState>(
      buildWhen: (previous, current) =>
          current is DetailPlaceShowMenuState ||
          current is DetailPlaceSelectMenuState,
      builder: (_, state) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: _cubit.isVisible ? 56.0 : 0.0,
          child: new Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: ListView.builder(
              itemCount: tabMenu.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () => _selectTab(index),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 56,
                    child: Stack(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              tabMenu[index],
                              style: _cubit.currentIndex == index
                                  ? TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor)
                                  : Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: _cubit.currentIndex == index ? 4 : 0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Padding _buildSumarryReview(PlaceModel? place) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Đánh giá từ cộng đồng',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 4,
              ),
              Text('${place?.reviewCount ?? 0} đánh giá')
            ],
          ),
          GestureDetector(
            onTap: () => _cubit.addReview(context),
            child: Container(
              height: 40,
              width: 127,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).primaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    ConstantIcons.ic_plus,
                    width: 16,
                    height: 16,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Viết đánh giá',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildInfoContactView(PlaceModel? place) {
    List<LocalSocialModel> socials = [];
    if (place?.social != null) {
      if (place?.social?.facebook != null) {
        socials.add(LocalSocialModel(
            icon: ConstantIcons.ic_fb, value: place?.social?.facebook ?? ''));
      }
      if (place?.social?.instagram != null) {
        socials.add(LocalSocialModel(
            icon: ConstantIcons.ic_instagram,
            value: place?.social?.instagram ?? ''));
      }
    }
    return Container(
      margin: const EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 12),
            blurRadius: 24,
            color: ColorConstant.grey_shadow.withOpacity(0.08),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông tin liên hệ',
            style: Theme.of(context).textTheme.headline4,
          ),
          ListView.builder(
            itemCount: socials.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 18),
            itemBuilder: (_, index) {
              final item = socials[index];
              return _buildItemContact(
                item.icon,
                item.value,
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildItemContact(
    String icon,
    String value,
  ) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => AppUtils.launchLink(value),
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
                          decoration: TextDecoration.underline,
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

  Container _buildMapView(PlaceModel? place) {
    return Container(
      height: 265,
      margin: const EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
      ),
      padding: const EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 12),
            blurRadius: 24,
            color: ColorConstant.grey_shadow.withOpacity(0.08),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bản đồ',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(
            height: 16,
          ),
          place == null
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ShimmerImage(),
                  ),
                )
              : Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            ConstantIcons.ic_primary_marker,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              place.address?.specific ?? '',
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: MiniMapView(
                          lat: place.address?.geo?.lat,
                          long: place.address?.geo?.long,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Container _buildMenuView(PlaceModel? place) {
    return Container(
      height: 144,
      margin: const EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
      ),
      padding: const EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 12),
            blurRadius: 24,
            color: ColorConstant.grey_shadow.withOpacity(0.08),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thực đơn',
            style: Theme.of(context).textTheme.headline4,
          ),
          Container(
            height: 72,
            margin: const EdgeInsets.only(top: 16),
            child: place == null
                ? ShimmerImage()
                : ListView.builder(
                    itemCount: place.menu.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      final item = place.menu[index];
                      return Container(
                        height: 72,
                        width: 72,
                        margin: const EdgeInsets.only(right: 8),
                        child: Stack(
                          children: [
                            ClipRRectImage(
                              onPressed: () => AppUtils.showBottomDialog(
                                context,
                                FullImageView(
                                  [item.path ?? ''],
                                ),
                              ),
                              height: 72,
                              width: 72,
                              url: AppUtils.getUrlImage(
                                item.path ?? '',
                                width: 200,
                                height: 200,
                              ),
                              radius: 8,
                            )
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Container _buildWorkHourView(PlaceModel? place) {
    return Container(
      height: 116,
      margin: const EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
      ),
      padding: const EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 12),
            blurRadius: 24,
            color: ColorConstant.grey_shadow.withOpacity(0.08),
          )
        ],
      ),
      child: place == null
          ? Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ShimmerImage(),
            )
          : Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Khung giờ mở cửa',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => AppUtils.showBottomDialog(
                        context,
                        AllOpeningTimeView(
                          openingTime: place.openingTime,
                        ),
                      ),
                      child: Text(
                        'Xem tất cả',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      ConstantIcons.ic_chevron_right,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorConstant.neutral_gray_lightest,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Đang mở cửa',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          place.openingTime != null
                              ? AppUtils.getTimeOpening(place.openingTime!)
                              : '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }

  Container _buildRangePriceView(PlaceModel? place) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 12),
            blurRadius: 24,
            color: ColorConstant.grey_shadow.withOpacity(0.08),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Khoảng giá',
            style: Theme.of(context).textTheme.headline4,
          ),
          Expanded(
            child: Text(
              place != null
                  ? 'Từ ${AppUtils.formatCurrency(place.price?.min ?? 0)}đ - ${AppUtils.formatCurrency(place.price?.max ?? 0)}đ'
                  : '',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildRatingView(PlaceModel? place) {
    return Container(
      height: 183,
      margin: const EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 12),
            blurRadius: 24,
            color: ColorConstant.grey_shadow.withOpacity(0.08),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Đánh giá địa điểm',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Text(
                '${place?.reviewCount ?? 0} đánh giá',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          place == null
              ? Expanded(
                  child: ShimmerImage(),
                )
              : Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _buildReviewItem(
                      'Vị trí',
                      place.rate?.position ?? 0,
                    ),
                    _buildReviewItem(
                      'Không gian',
                      place.rate?.view ?? 0,
                    ),
                    _buildReviewItem(
                      'Ăn uống',
                      place.rate?.drink ?? 0,
                    ),
                    _buildReviewItem(
                      'Phục vụ',
                      place.rate?.service ?? 0,
                    ),
                    _buildReviewItem(
                      'Giá cả',
                      place.rate?.price ?? 0,
                    ),
                  ],
                )
        ],
      ),
    );
  }

  Widget _buildContactView() {
    return BlocBuilder<DetailPlaceCubit, DetailPlaceState>(
      buildWhen: (previous, current) => current is DetailPlaceGetDoneState,
      builder: (_, state) {
        return Container(
          height: 50,
          margin: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 12),
                blurRadius: 24,
                color: ColorConstant.grey_shadow.withOpacity(0.08),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Liên hệ',
                style: Theme.of(context).textTheme.headline4,
              ),
              _cubit.place != null &&
                      _cubit.place!.phone != null &&
                      _cubit.place!.phone != ''
                  ? InkWell(
                      onTap: () => _cubit.makePhoneCall(),
                      child: Container(
                        height: 32,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              ConstantIcons.ic_book_contact,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Gọi điện',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Text(
                      'Chưa cập nhật số điện thoại',
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorConstant.neutral_black,
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildReviewItem(
    String title,
    double value,
  ) {
    return UnconstrainedBox(
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorConstant.neutral_gray_lightest,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: title,
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorConstant.neutral_black,
                      ),
                    ),
                    TextSpan(
                      text: ' ($value/5.0)',
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorConstant.neutral_gray,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Image.asset(
                ConstantIcons.ic_very_good,
                height: 16,
                width: 16,
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _buildConveniencesView(PlaceModel? place) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
      ),
      padding: const EdgeInsets.only(
        left: 16,
        top: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 12),
            blurRadius: 24,
            color: ColorConstant.grey_shadow.withOpacity(0.08),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Tiện ích',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Text(
                '${place?.benefits.length ?? 0} tiện ích',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SvgPicture.asset(
                ConstantIcons.ic_chevron_right,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                width: 16,
              ),
            ],
          ),
          Container(
            height: 32,
            margin: const EdgeInsets.only(top: 16),
            child: place == null
                ? ShimmerImage()
                : ListView.builder(
                    itemCount: place.benefits.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      final item = place.benefits[index];
                      return Container(
                        height: 32,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: ColorConstant.neutral_gray_lightest,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              IconDataSolid(
                                getHexFromStr(item.code ?? ''),
                              ),
                              size: 20,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              item.name ?? '',
                              style: TextStyle(
                                fontSize: 12,
                                color: ColorConstant.neutral_black,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }

  Container _buildInfoView(PlaceModel? place) {
    return Container(
      height: 370,
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 12),
            blurRadius: 24,
            color: ColorConstant.grey_shadow.withOpacity(0.08),
          )
        ],
      ),
      child: place == null
          ? Column(
              children: [
                Row(
                  children: [
                    ShimmerImage(
                      shape: BoxShape.circle,
                      width: 52,
                      height: 52,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ShimmerParagraph(),
                    ),
                  ],
                ),
                ShimmerParagraph(),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ShimmerImage(),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRectImage(
                      height: 52,
                      width: 52,
                      radius: 26,
                      url: AppUtils.getUrlImage(
                        place.avatar?.path ?? '',
                        width: 200,
                        height: 200,
                      ),
                    ),
                    SizedBox(
                      width: 9,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   place.name ?? '',
                          //   maxLines: 1,
                          //   overflow: TextOverflow.ellipsis,
                          //   style: Theme.of(context).textTheme.headline3,
                          // ),
                          overFlowText(
                            place.name ?? '',
                            Theme.of(context).textTheme.headline3!,
                            1,
                            readMore: _onReadMore,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              MyRatingBar(
                                rating: place.rate?.summary ?? 0,
                                onRatingUpdate: (rate, isEmpty) {},
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '(${place.reviewCount ?? 0} đánh giá)',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: ColorConstant.neutral_gray,
                                ),
                              )
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: VerifiedView(
                              margin: const EdgeInsets.only(
                                top: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   height: 36,
                    //   width: 36,
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     border: Border.all(
                    //       color: Theme.of(context).primaryColor,
                    //     ),
                    //   ),
                    //   child: Center(
                    //     child: SvgPicture.asset(
                    //       ConstantIcons.ic_book_mark,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      ConstantIcons.ic_marker_filled,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      place.region?.name ?? '',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    GestureDetector(
                      onTap: () => _cubit.openMap(),
                      child: Text(
                        ' - Bản đồ chỉ đường',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                overFlowText(
                  place.intro ?? '',
                  Theme.of(context).textTheme.bodyText1!.copyWith(
                        height: 1.5,
                      ),
                  2,
                  isRow: false,
                  readMore: _onReadMore,
                ),
                // Text(
                //   place.intro ?? '',
                //   maxLines: 2,
                //   overflow: TextOverflow.ellipsis,
                //   style: Theme.of(context)
                //       .textTheme
                //       .bodyText1
                //       ?.copyWith(height: 1.5),
                // ),
                Container(
                  height: 72,
                  margin: const EdgeInsets.only(top: 24),
                  child: ListView.builder(
                    itemCount: place.images.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      final item = place.images[index];
                      return Container(
                        height: 72,
                        width: 72,
                        margin: const EdgeInsets.only(right: 8),
                        child: Stack(
                          children: [
                            ClipRRectImage(
                              onPressed: () => AppUtils.showBottomDialog(
                                context,
                                FullImageView(
                                  place.images
                                      .map((e) => e.path ?? '')
                                      .toList(),
                                  currentIndex: index,
                                ),
                              ),
                              height: 72,
                              width: 72,
                              url: AppUtils.getUrlImage(
                                item.path ?? '',
                                width: 200,
                                height: 200,
                              ),
                              radius: 8,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: 40,
                  margin: const EdgeInsets.only(top: 24),
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  decoration: BoxDecoration(
                    color: ColorConstant.neutral_gray_lightest,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(ConstantIcons.ic_discountstore),
                      SizedBox(
                        width: 7,
                      ),
                      Expanded(
                        child: Text(
                          '40 khuyến mãi',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        ConstantIcons.ic_chevron_right,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }

  _onReadMore() {
    AppUtils.showBottomDialog(
      context,
      FullNameContentPlaceView(
        place: _cubit.place!,
      ),
    );
  }

  Widget overFlowText(
    String text,
    TextStyle style,
    int maxLines, {
    bool isRow = true,
    Function()? readMore,
  }) {
    return LayoutBuilder(
      builder: (context, size) {
        // Build the textspan
        var span = TextSpan(
          text: text,
          style: style,
        );

        // Use a textpainter to determine if it will exceed max lines
        var tp = TextPainter(
          maxLines: maxLines,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
          text: span,
        );

        // trigger it to layout
        tp.layout(maxWidth: size.maxWidth);

        // whether the text overflowed or not
        var exceeded = tp.didExceedMaxLines;

        return isRow
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Text.rich(
                      span,
                      overflow: TextOverflow.ellipsis,
                      maxLines: maxLines,
                    ),
                  ),
                  exceeded
                      ? GestureDetector(
                          onTap: readMore,
                          child: Text(
                            "Xem thêm",
                            style: TextStyle(
                              fontSize: 10,
                              color: ColorConstant.neutral_gray,
                            ),
                          ),
                        )
                      : SizedBox.shrink()
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text.rich(
                    span,
                    overflow: TextOverflow.ellipsis,
                    maxLines: maxLines,
                  ),
                  SizedBox(
                    height: exceeded ? 4 : 0,
                  ),
                  exceeded
                      ? GestureDetector(
                          onTap: readMore,
                          child: Text(
                            "Xem thêm",
                            style: TextStyle(
                              fontSize: 10,
                              color: ColorConstant.neutral_gray,
                            ),
                          ),
                        )
                      : SizedBox.shrink()
                ],
              );
      },
    );
  }

  Container _buildSlider(PlaceModel? place, int currentIndex) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 268,
      child: Stack(
        children: [
          place == null
              ? ShimmerImage()
              : PageView.builder(
                  itemCount: place.images.length,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index) {
                    print(index);
                    _cubit.changePage(index);
                  },
                  itemBuilder: (_, index) {
                    final item = place.images[index];
                    return ClipRRectImage(
                      height: double.infinity,
                      width: double.infinity,
                      url: AppUtils.getUrlImage(
                        item.path ?? '',
                      ),
                    );
                  },
                ),
          place == null
              ? SizedBox.shrink()
              : Positioned(
                  right: 16,
                  bottom: 32,
                  child: Container(
                    width: 52,
                    height: 22,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: Center(
                      child: Text(
                        '${currentIndex + 1}/${place.images.length}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}

int getHexFromStr(String fontCode) {
  int val = 0;
  int len = fontCode.length;
  for (int i = 0; i < len; i++) {
    int hexDigit = fontCode.codeUnitAt(i);
    if (hexDigit >= 48 && hexDigit <= 57) {
      val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 65 && hexDigit <= 70) {
      // A..F
      val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 97 && hexDigit <= 102) {
      // a..f
      val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
    } else {
      throw new FormatException("An error occurred when converting");
    }
  }
  return val;
}
