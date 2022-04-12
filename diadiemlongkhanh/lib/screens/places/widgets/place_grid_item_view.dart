import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlaceGridItemView extends StatelessWidget {
  const PlaceGridItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      fontSize: 10, color: ColorConstant.neutral_gray_lighter),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
