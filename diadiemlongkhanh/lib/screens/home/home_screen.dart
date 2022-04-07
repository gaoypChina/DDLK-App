import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:diadiemlongkhanh/widgets/dots_view.dart';
import 'package:diadiemlongkhanh/widgets/main_text_form_field.dart';
import 'package:diadiemlongkhanh/widgets/my_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  int _indexSlide = 0;
  @override
  void initState() {
    print('home');
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            bottom: 30,
          ),
          child: Column(
            children: [
              _buildHeaderView(),
              _buildSearchView(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 24,
                      ),
                      _buildSliderView(),
                      SizedBox(
                        height: 12,
                      ),
                      DotsView(step: 0),
                      _buildMenuView(),
                      SizedBox(
                        height: 37,
                      ),
                      _buildListHorizontalSingleView(
                        title: 'Địa điểm gần bạn',
                      ),
                      _buildListHorizontalSingleView(
                        title: 'Tìm kiếm nhiều nhất',
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
                            ListView.builder(
                              itemCount: 3,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 16),
                              itemBuilder: (_, index) {
                                return Container(
                                  height: 561,
                                  padding: const EdgeInsets.only(
                                    top: 12,
                                    left: 12,
                                    right: 12,
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
                                        color: ColorConstant.grey_shadow
                                            .withOpacity(0.12),
                                        offset: Offset(0, 12),
                                        blurRadius: 40,
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
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
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2,
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
                                                    Text(
                                                      'Harleys The Coffee',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2,
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
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: ColorConstant
                                                            .neutral_gray_lighter,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 7,
                                                    ),
                                                    MyRatingBar(
                                                      rating: 4,
                                                      onRatingUpdate:
                                                          (rate, isEmpty) {},
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                        left: 5,
                                                        right: 8,
                                                      ),
                                                      height: 4,
                                                      width: 4,
                                                      decoration: BoxDecoration(
                                                        color: ColorConstant
                                                            .neutral_gray_lighter,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                      ),
                                                    ),
                                                    Text(
                                                      '7 ngày trước',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: ColorConstant
                                                            .neutral_gray_lighter,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          _buildFollowButton(context),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
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

  Column _buildGridView(BuildContext context) {
    return Column(
      children: [
        _buildHeaderSection('Địa điểm mới cập nhật'),
        Container(
          height: 28,
          margin: const EdgeInsets.only(top: 24),
          child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16),
              itemBuilder: (_, index) {
                return Container(
                  height: 28,
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: index == 0
                        ? ColorConstant.green_D5F4D9
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      'Tất cả',
                      style: index == 0
                          ? TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor,
                            )
                          : Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                );
              }),
        ),
        Container(
          // height: 900,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 6,
            shrinkWrap: true,
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 10,
              bottom: 48,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: 238),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 238,
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRectImage(
                        radius: 8,
                        url:
                            'https://cdn.tgdd.vn/Files/2019/07/03/1177014/nau-banh-canh-ghe-co-gi-ma-kho-doc-ngay-bai-viet-nay-la-biet-lam-ngay-202112221144210167.jpg',
                        height: 148,
                        width: double.infinity,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Đang mở cửa',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor,
                            ),
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
                      Text(
                        'Bún riêu hột vịt lộn – Bún bò quán Nhỏ Xíu ',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: ColorConstant.neutral_black,
                        ),
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
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Container _buildPromotionListView() {
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
          _buildHeaderSection('Khuyến mãi tháng 4'),
          Expanded(
            child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 16, top: 16),
                itemBuilder: (_, index) {
                  return Container(
                    width: 218,
                    margin: const EdgeInsets.only(right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRectImage(
                          radius: 12,
                          url:
                              'https://images.foody.vn/res/g1/4084/prof/s1242x600/image-9700d6cc-210613161452.jpeg',
                          height: 122,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Áp dụng toàn menu',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Giảm giá 30%',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: ColorConstant.orange_secondary,
                          ),
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
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

  Column _buildListHorizontalSingleView({required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderSection(title),
        Container(
          height: 314,
          child: ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(
                top: 16,
                left: 16,
                bottom: 40,
              ),
              itemBuilder: (_, index) {
                return Container(
                  width: 194,
                  margin: const EdgeInsets.only(
                    right: 16,
                  ),
                  padding: const EdgeInsets.only(
                    top: 12,
                    right: 12,
                    left: 12,
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
                      ]),
                  child: Column(
                    children: [
                      ClipRRectImage(
                        url:
                            'https://thietkecafedep.com.vn/upload/news/nha-hang-the-gangs-cao-thang-2-7874.jpg',
                        radius: 8,
                        width: 170,
                        height: 170,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Đang mở cửa',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor,
                            ),
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
                      Text(
                        'Bún riêu hột vịt lộn – Bún bò quán Nhỏ Xíu ',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 2,
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
                          )
                        ],
                      )
                    ],
                  ),
                );
              }),
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
                icon: Image.asset(
                  ConstantIcons.ic_map,
                  width: 46,
                  height: 37,
                ),
              ),
              _buildMenuItem(
                title: 'Khám phá',
                icon: Image.asset(
                  ConstantIcons.ic_binoculars,
                  width: 41,
                  height: 37,
                ),
              ),
              _buildMenuItem(
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

  Column _buildMenuItem({
    Widget? icon,
    required String title,
  }) {
    return Column(
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
    );
  }

  Container _buildSliderView() {
    return Container(
      height: 180,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 6,
            bottom: 6,
            left: 0,
            right: 0,
            child: Container(
              color: _indexSlide == 0 ? Colors.red : Colors.green,
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 12,
            right: 12,
            child: SwipeDetector(
              onSwipeLeft: (offset) {
                print(offset);
                if (_indexSlide == 1) {
                  return;
                }
                setState(() {
                  _indexSlide += 1;
                });
              },
              onSwipeRight: (offset) {
                print(offset);
                if (_indexSlide == 0) {
                  return;
                }
                setState(() {
                  _indexSlide -= 1;
                });
              },
              child: Container(
                color: _indexSlide == 0 ? Colors.green : Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _buildSearchView(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
      ),
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
    );
  }

  Widget _buildHeaderView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Image.network(
              'https://photo-cms-nghenhinvietnam.zadn.vn/w700/Uploaded/2022/cadwpqrnd/2022_03_06/anya_taylor_joy_900x506_pvfv.jpg',
              fit: BoxFit.cover,
              width: 44,
              height: 44,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              'User Name Here',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Container(
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
          )
        ],
      ),
    );
  }
}
