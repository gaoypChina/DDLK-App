import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlaceHorizItemView extends StatelessWidget {
  const PlaceHorizItemView({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
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
                    fontSize: 10, color: ColorConstant.neutral_gray_lighter),
              )
            ],
          )
        ],
      ),
    );
  }
}
