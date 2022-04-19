import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:diadiemlongkhanh/widgets/my_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DetailPlaceScreen extends StatefulWidget {
  const DetailPlaceScreen({Key? key}) : super(key: key);

  @override
  _DetailPlaceScreenState createState() => _DetailPlaceScreenState();
}

class _DetailPlaceScreenState extends State<DetailPlaceScreen> {
  ScrollController scrollController = new ScrollController();
  bool isVisible = false;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isVisible)
          setState(() {
            isVisible = true;
          });
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isVisible)
          setState(() {
            isVisible = false;
          });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.grey_F2F4F8,
      appBar: MyAppBar(
        title: 'Chi tiết địa điểm',
      ),
      body: Stack(
        children: <Widget>[
          _buildSlider(),
          CustomScrollView(
            controller: scrollController,
            shrinkWrap: true,
            slivers: <Widget>[
              new SliverPadding(
                padding: const EdgeInsets.all(0),
                sliver: new SliverList(
                  delegate: new SliverChildListDelegate(
                    <Widget>[
                      Container(
                        height: 350,
                        margin: const EdgeInsets.only(
                          top: 248,
                          left: 16,
                          right: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 12),
                              blurRadius: 24,
                              color:
                                  ColorConstant.grey_shadow.withOpacity(0.08),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ClipRRectImage(
                                  height: 52,
                                  width: 52,
                                  radius: 26,
                                  url:
                                      'https://dongphucbonmua.com/wp-content/uploads/2021/09/dong-phuc-highlands-coffee2-min.jpg',
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Highland Coffee',
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                    Row(
                                      children: [
                                        MyRatingBar(
                                          rating: 4,
                                          onRatingUpdate: (rate, isEmpty) {},
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          '(1600 đánh giá)',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: ColorConstant.neutral_gray,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            height: isVisible ? 60.0 : 0.0,
            child: new Container(
              color: Colors.green,
              width: MediaQuery.of(context).size.width,
              child: Center(child: Text("Container")),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildSlider() {
    return Container(
      height: 268,
      child: Stack(children: [
        PageView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return ClipRRectImage(
              height: double.infinity,
              width: double.infinity,
              url:
                  'https://aeonmall-haiphong-lechan.com.vn/wp-content/uploads/2020/12/hc-flagships-750x468-1.png',
            );
          },
        ),
        Positioned(
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
                '1/12',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
