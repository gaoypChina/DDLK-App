import 'package:diadiemlongkhanh/models/remote/voucher/voucher_response.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:diadiemlongkhanh/widgets/line_dashed_painter.dart';
import 'package:flutter/material.dart';

class ListPromotionView extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final List<VoucherModel> vouhchers;
  ListPromotionView({
    this.margin,
    required this.vouhchers,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: vouhchers.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: margin,
      itemBuilder: (_, index) {
        final item = vouhchers[index];
        return InkWell(
          onTap: () => Navigator.of(context).pushNamed(
            RouterName.detail_promotion,
            arguments: item.id,
          ),
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
                          url: AppUtils.getUrlImage(
                            item.thumbnail?.path ?? '',
                            width: 96,
                            height: 96,
                          ),
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
                                item.place?.name ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              Text(
                                item.place?.name ?? '',
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
                                    item.title ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstant.orange_secondary,
                                    ),
                                  ),
                                  Text(
                                    item.endDate != null
                                        ? AppUtils.getExpireDate(item.endDate!)
                                        : '',
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
