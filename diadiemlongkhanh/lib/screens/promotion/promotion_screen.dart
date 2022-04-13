import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:flutter/material.dart';

class PromotionScreen extends StatefulWidget {
  const PromotionScreen({Key? key}) : super(key: key);

  @override
  _PromotionScreenState createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  List<String> filterDatas = ['Tất cả', 'Cơm', 'Bún', 'Phở'];
  int _indexFilter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.grey_F2F4F8,
      appBar: MyAppBar(
        title: 'Khuyến mãi',
        isShowBgBackButton: false,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              bottom: 0,
              child: Image.asset(
                ConstantImages.left_pin,
                width: 153,
                height: 116,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 120,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeaderPromotionVie(context),
                    _buildFilterPromotionView(),
                    _buildListPromotionView(context)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _buildHeaderPromotionVie(BuildContext context) {
    return Container(
      height: 280,
      margin: const EdgeInsets.only(
        top: 28,
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.green_shadow.withOpacity(0.12),
            offset: Offset(0, 15),
            blurRadius: 40,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRectImage(
            radius: 8,
            height: 189,
            width: double.infinity,
            url:
                'https://img.giftpop.vn/brand/GOGIHOUSE/MP1905280011_BASIC_origin.jpg',
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mono Coffee Lab',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'Số 3, Đường A, Phường Xuân an',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorConstant.neutral_gray,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Giảm giá 30%',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorConstant.orange_secondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListView _buildListPromotionView(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 24),
      itemBuilder: (_, index) {
        return InkWell(
          onTap: () =>
              Navigator.of(context).pushNamed(RouterName.detail_promotion),
          child: Container(
            height: 112,
            margin: const EdgeInsets.only(
              bottom: 16,
              left: 16,
              right: 16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstant.green_shadow.withOpacity(0.12),
                          offset: Offset(0, 15),
                          blurRadius: 40,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRectImage(
                          radius: 8,
                          url:
                              'https://img.giftpop.vn/brand/GOGIHOUSE/MP1905280011_BASIC_origin.jpg',
                          width: 96,
                          height: double.infinity,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Mono Coffee Lab',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              Text(
                                'Số 3, Đường A, Phường Xuân an',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ColorConstant.neutral_gray,
                                ),
                              ),
                              SizedBox(
                                height: 11,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Giảm giá 30%',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstant.orange_secondary,
                                    ),
                                  ),
                                  Text(
                                    'Còn 15 ngày',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
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
                  ),
                ),
                Container(
                  height: 112,
                  child: CustomPaint(
                    painter: LineDashedPainter(),
                  ),
                ),
                Container(
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Chi tiết',
                      style: Theme.of(context).textTheme.headline2?.apply(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Container _buildFilterPromotionView() {
    return Container(
      height: 28,
      margin: const EdgeInsets.only(
        top: 48,
        left: 16,
        right: 16,
      ),
      child: ListView.builder(
        itemCount: filterDatas.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return Container(
            height: 28,
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: index == _indexFilter
                  ? ColorConstant.green_D5F4D9
                  : Colors.transparent,
            ),
            child: Center(
              child: Text(
                filterDatas[index],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight:
                      index == _indexFilter ? FontWeight.w500 : FontWeight.w400,
                  color: index == _indexFilter
                      ? Theme.of(context).primaryColor
                      : ColorConstant.neutral_gray,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LineDashedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.strokeWidth = 1;
    paint.color = ColorConstant.neutral_gray_lighter;

    var dashWidth = 6;
    var dashSpace = 4;
    double startY = 10;
    while (startY < size.height - 10) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      final space = (dashSpace + dashWidth);
      startY += space;
      print(startY);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
