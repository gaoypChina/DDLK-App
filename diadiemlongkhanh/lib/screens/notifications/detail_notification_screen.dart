import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:diadiemlongkhanh/widgets/main_button.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:flutter/material.dart';

class DetailNotificationScreen extends StatefulWidget {
  const DetailNotificationScreen({Key? key}) : super(key: key);

  @override
  _DetailNotificationScreenState createState() =>
      _DetailNotificationScreenState();
}

class _DetailNotificationScreenState extends State<DetailNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.grey_F2F4F8,
      appBar: MyAppBar(
        title: 'Thông báo',
      ),
      body: Container(
        height: double.infinity,
        child: Stack(
          children: [
            ClipRRectImage(
              height: 225,
              width: double.infinity,
              url:
                  'https://static.hotdeal.vn/images/1532/1531992/60x60/349432-king-bbq-menu-329k-buffet-nuong-lau-dang-cap-vua-nuong-han-quoc.jpg',
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 198),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 8),
                            blurRadius: 20,
                            color:
                                ColorConstant.neutral_black.withOpacity(0.12),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 52,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: ColorConstant.neutral_gray_lightest,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Update v1.0',
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                                Text(
                                  '22/02/2022 lúc 6:30',
                                  style: Theme.of(context).textTheme.subtitle1,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    MainButton(
                      title: 'KHÁM PHÁ THÊM',
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
