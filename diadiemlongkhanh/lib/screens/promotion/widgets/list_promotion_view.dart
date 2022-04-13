import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:diadiemlongkhanh/widgets/line_dashed_painter.dart';
import 'package:flutter/material.dart';

class ListPromotionView extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  ListPromotionView({this.margin});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: margin,
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
}
