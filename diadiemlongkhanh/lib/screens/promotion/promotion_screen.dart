import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
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
                    Container(
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
                    ),
                    _buildFilterPromotionView(),
                    ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(top: 24),
                      itemBuilder: (_, index) {
                        return Container(
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
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorConstant.green_shadow
                                              .withOpacity(0.12),
                                          offset: Offset(0, 15),
                                          blurRadius: 40,
                                        ),
                                      ]),
                                ),
                              ),
                              Container(
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
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
