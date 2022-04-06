import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/widgets/dots_view.dart';
import 'package:diadiemlongkhanh/widgets/main_text_form_field.dart';
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
            left: 16,
            right: 16,
          ),
          child: Column(
            children: [
              _buildHeaderView(),
              _buildSearchView(context),
              SizedBox(
                height: 24,
              ),
              _buildSliderView(),
              SizedBox(
                height: 12,
              ),
              DotsView(step: 0),
              Container(
                height: 196,
                margin: const EdgeInsets.only(top: 20),
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
                            icon: Image.asset(
                          ConstantIcons.ic_map,
                          width: 46,
                          height: 37,
                        )),
                        _buildMenuItem(),
                        _buildMenuItem(),
                        _buildMenuItem(),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildMenuItem(),
                        _buildMenuItem(),
                        _buildMenuItem(),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column _buildMenuItem({Widget? icon}) {
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
          'Gần đây',
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
      margin: const EdgeInsets.only(top: 16),
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

  Row _buildHeaderView() {
    return Row(
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
    );
  }
}
