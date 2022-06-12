import 'package:diadiemlongkhanh/models/local/report_type_model.dart';
import 'package:diadiemlongkhanh/models/remote/new_feed/new_feed_response.dart';
import 'package:diadiemlongkhanh/models/remote/place_response/place_response.dart';
import 'package:diadiemlongkhanh/models/remote/slide/slide_response.dart';
import 'package:diadiemlongkhanh/models/remote/voucher/voucher_response.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/screens/home/bloc/home_cubit.dart';
import 'package:diadiemlongkhanh/screens/home/widgets/custom_slider_view.dart';
import 'package:diadiemlongkhanh/screens/new_feeds/widgets/new_feed_item_view.dart';
import 'package:diadiemlongkhanh/screens/places/widgets/place_action_dialog.dart';
import 'package:diadiemlongkhanh/screens/places/widgets/place_horiz_item_view.dart';
import 'package:diadiemlongkhanh/screens/places/widgets/places_grid_view.dart';
import 'package:diadiemlongkhanh/screens/skeleton_view/shimmer_image.dart';
import 'package:diadiemlongkhanh/screens/skeleton_view/shimmer_newfeed.dart';
import 'package:diadiemlongkhanh/screens/skeleton_view/shimmer_paragraph.dart';
import 'package:diadiemlongkhanh/screens/skeleton_view/skeleton_voucher.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/services/storage/storage_service.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/utils/global_value.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:diadiemlongkhanh/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = true;
  HomeCubit get _cubit => BlocProvider.of(context);
  bool _isScroll = false;
  @override
  void initState() {
    print('home');
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getData();
    });
  }

  getData() async {
    _cubit.getSlides();

    Future.delayed(
      Duration(seconds: 1),
      () {
        setState(() {
          _isScroll = true;
        });
        _cubit.getInfoUser();
        _cubit.getPlacesNear();
        _cubit.getPlacesHot();
        _cubit.getVouchers();
        _cubit.getSubCategories();
        _cubit.getNewFeeds();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 16,
            ),
            child: Column(
              children: [
                _buildHeaderView(),
                _buildSearchView(context),
                Expanded(
                  child: SingleChildScrollView(
                    physics: _isScroll
                        ? ScrollPhysics()
                        : NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        _buildSliderView(),
                        SizedBox(
                          height: 20,
                        ),
                        _buildMenuView(),
                        SizedBox(
                          height: 37,
                        ),
                        BlocBuilder<HomeCubit, HomeState>(
                          buildWhen: (previous, current) =>
                              current is HomeGetPlaceNearDoneState,
                          builder: (_, state) {
                            List<PlaceModel> places = [];
                            if (state is HomeGetPlaceNearDoneState) {
                              places = state.places;
                            }
                            return _buildListHorizontalSingleView(
                              title: 'Địa điểm gần bạn',
                              places: places,
                            );
                          },
                        ),
                        BlocBuilder<HomeCubit, HomeState>(
                          buildWhen: (previous, current) =>
                              current is HomeGetPlaceHotDoneState,
                          builder: (_, state) {
                            List<PlaceModel> places = [];
                            if (state is HomeGetPlaceHotDoneState) {
                              places = state.places;
                            }
                            return _buildListHorizontalSingleView(
                              title: 'Tìm kiếm nhiều nhất',
                              places: places,
                            );
                          },
                        ),
                        _buildPromotionListView(),
                        _buildGridView(context),
                        Container(
                          height: 15,
                          color: ColorConstant.neutral_gray_lightest,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: Column(
                            children: [
                              _buildHeaderSection(
                                'Khám phá',
                                showIcon: false,
                              ),
                              _buildListNewFeedsView(),
                              MainButton(
                                title: 'KHÁM PHÁ THÊM',
                                onPressed: () =>
                                    Navigator.of(context).pushNamed(
                                  RouterName.new_feeds,
                                  arguments: true,
                                ),
                                margin: const EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  bottom: 30,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListNewFeedsView() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is HomeGetNewFeedsDoneState,
      builder: (_, state) {
        List<NewFeedModel> newfeeds = _cubit.reviews;

        return ListView.builder(
          itemCount: newfeeds.isEmpty ? 5 : newfeeds.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 16, bottom: 24),
          itemBuilder: (_, index) {
            return newfeeds.isEmpty
                ? ShimmerNewFeed(
                    context,
                  )
                : NewFeedItemView(
                    item: newfeeds[index],
                    moreSelect: () => AppUtils.showBottomDialog(
                      context,
                      PlaceActionDiaglog(
                        type: ReportType.review,
                        docId: newfeeds[index].id,
                      ),
                    ),
                    isShowComment:
                        injector.get<StorageService>().getToken() != null,
                    nextToDetail: () => Navigator.of(context).pushNamed(
                      RouterName.detail_review,
                      arguments: newfeeds[index],
                    ),
                    likePressed: () => _cubit.likePost(
                      context,
                      index,
                    ),
                    sendComment: () => _cubit.sendComment(index),
                  );
          },
        );
      },
    );
  }

  Column _buildGridView(BuildContext context) {
    return Column(
      children: [
        _buildHeaderSection('Địa điểm mới cập nhật'),
        _buildListSubCategoriesView(context),
        BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) => current is HomeGetPlaceNewDoneState,
          builder: (_, state) {
            List<PlaceModel> places = [];
            if (state is HomeGetPlaceNewDoneState) {
              places = state.places;
            }
            return PlacesGridView(
              places: places,
              physics: NeverScrollableScrollPhysics(),
              onSelect: (item) => Navigator.of(context).pushNamed(
                RouterName.detail_place,
                arguments: item.id,
              ),
            );
          },
        )
      ],
    );
  }

  Widget _buildListSubCategoriesView(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is HomeGetSubCategoriesDoneState ||
          current is HomeSelectSubCategoryState,
      builder: (_, state) {
        return Container(
          height: 28,
          margin: const EdgeInsets.only(top: 24),
          child: ListView.builder(
              itemCount: _cubit.subCategories.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16),
              itemBuilder: (_, index) {
                final item = _cubit.subCategories[index];
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _cubit.selectSubCategory(index),
                  child: Container(
                    height: 28,
                    margin: const EdgeInsets.only(right: 16),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: index == _cubit.subCategoryIndex
                          ? ColorConstant.green_D5F4D9
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        item.name ?? '',
                        style: index == _cubit.subCategoryIndex
                            ? TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor,
                              )
                            : Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }

  Widget _buildPromotionListView() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is HomeGetVouchersDoneState,
      builder: (_, state) {
        List<VoucherModel> vouchers = [];
        if (state is HomeGetVouchersDoneState) {
          vouchers = state.vouchers;
        }
        return Container(
          height: 250,
          margin: const EdgeInsets.only(bottom: 40),
          decoration: BoxDecoration(
            color: ColorConstant.grey_F1F5F2,
            image: DecorationImage(
              image: AssetImage(ConstantImages.world_map),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              _buildHeaderSection('Khuyến mãi Hot'),
              Expanded(
                child: ListView.builder(
                    itemCount: vouchers.isEmpty ? 5 : vouchers.length,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 16, top: 16),
                    itemBuilder: (_, index) {
                      return Container(
                        width: 218,
                        margin: const EdgeInsets.only(right: 16),
                        child: vouchers.isEmpty
                            ? SkeletonVoucher()
                            : GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => Navigator.of(context).pushNamed(
                                  RouterName.detail_promotion,
                                  arguments: vouchers[index].id,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRectImage(
                                      radius: 12,
                                      url: AppUtils.getUrlImage(
                                        vouchers[index].thumbnail?.path ?? '',
                                        height: 122,
                                      ),
                                      height: 122,
                                      width: double.infinity,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      vouchers[index].title ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      vouchers[index].content ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: ColorConstant.orange_secondary,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                      );
                    }),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeaderSection(
    String title, {
    bool showIcon = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          showIcon
              ? GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => print('asdasd'),
                  child: SvgPicture.asset(
                    ConstantIcons.ic_chevron_right,
                    width: 20,
                    height: 20,
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildListHorizontalSingleView({
    required String title,
    required List<PlaceModel> places,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderSection(title),
        Container(
          height: 314,
          child: ListView.builder(
            itemCount: places.isEmpty ? 10 : places.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(
              top: 16,
              left: 16,
              bottom: 40,
            ),
            itemBuilder: (_, index) {
              return places.isEmpty
                  ? ShimmerImage(
                      width: 194,
                      height: 314,
                    )
                  : PlaceHorizItemView(
                      context: context,
                      item: places[index],
                      onPressed: () {
                        injector
                            .get<StorageService>()
                            .savePlaceIds(places[index].id ?? '');
                        Navigator.of(context).pushNamed(
                          RouterName.detail_place,
                          arguments: places[index].id ?? '',
                        );
                      },
                    );
            },
          ),
        )
      ],
    );
  }

  Container _buildMenuView() {
    return Container(
      height: 196,
      margin: const EdgeInsets.only(
        top: 20,
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 15),
            blurRadius: 40,
            color: ColorConstant.grey_shadow.withOpacity(0.12),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildMenuItem(
                title: 'Gần đây',
                onPressed: () => Navigator.of(context).pushNamed(
                  RouterName.list_places,
                  arguments: {
                    'near_me': true,
                  },
                ),
                icon: Image.asset(
                  ConstantIcons.ic_map,
                  width: 46,
                  height: 37,
                ),
              ),
              _buildMenuItem(
                title: 'Khám phá',
                onPressed: () => Navigator.of(context).pushNamed(
                  RouterName.new_feeds,
                  arguments: true,
                ),
                icon: Image.asset(
                  ConstantIcons.ic_binoculars,
                  width: 41,
                  height: 37,
                ),
              ),
              _buildMenuItem(
                onPressed: () =>
                    Navigator.of(context).pushNamed(RouterName.promotion),
                title: 'Khuyến mãi',
                icon: Image.asset(
                  ConstantIcons.ic_promotion,
                  width: 44,
                  height: 37,
                ),
              ),
              _buildMenuItem(
                title: 'Ăn uống',
                icon: Image.asset(
                  ConstantIcons.ic_food,
                  width: 42,
                  height: 37,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildMenuItem(
                title: 'Dịch vụ',
                icon: Image.asset(
                  ConstantIcons.ic_store,
                  width: 45,
                  height: 33,
                ),
              ),
              _buildMenuItem(
                title: 'Khách sạn',
                icon: Image.asset(
                  ConstantIcons.ic_hotel,
                  width: 45,
                  height: 49,
                ),
              ),
              _buildMenuItem(
                title: 'Du lịch',
                icon: Image.asset(
                  ConstantIcons.ic_travel,
                  width: 37,
                  height: 42,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    Function()? onPressed,
    Widget? icon,
    required String title,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            height: 56,
            width: 56,
            margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              color: ColorConstant.grey_F8F9FA,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: icon,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: ColorConstant.neutral_black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderView() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is HomeGetSlideDoneState,
      builder: (_, state) {
        List<SlideModel> slides = [];
        if (state is HomeGetSlideDoneState) {
          slides = state.slides;
        }
        return CustomSliderView(
          datas: slides,
        );
      },
    );
  }

  Widget _buildSearchView(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pushNamed(RouterName.search),
      child: Container(
        height: 48,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: ColorConstant.neutral_gray_lightest,
        ),
        child: Row(
          children: [
            SvgPicture.asset(ConstantIcons.ic_search),
            SizedBox(
              width: 16,
            ),
            Text(
              'Tìm kiếm mọi thứ',
              style: Theme.of(context).textTheme.subtitle1,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderView() {
    final token = injector.get<StorageService>().getToken();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: token == null
          ? Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(
                  RouterName.option_login,
                  arguments: true,
                ),
                child: Text(
                  'Đăng nhập/Đăng ký',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            )
          : BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) =>
                  current is HomeGetProfileDoneState,
              builder: (_, state) {
                return Row(
                  children: [
                    ClipRRectImage(
                      height: 44,
                      width: 44,
                      radius: 22,
                      url: AppUtils.getUrlImage(
                        GlobalValue.avatar ?? '',
                        width: 44,
                        height: 44,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        GlobalValue.name ?? '',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushNamed(RouterName.notification),
                      child: Container(
                        height: 36,
                        width: 36,
                        child: Stack(
                          children: [
                            Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: ColorConstant.neutral_gray_lightest,
                              ),
                              child: Center(
                                child: SvgPicture.asset(ConstantIcons.ic_bell),
                              ),
                            ),
                            Positioned(
                              top: 2,
                              right: 0,
                              child: Container(
                                height: 8,
                                width: 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: ColorConstant.sematic_red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
    );
  }
}
