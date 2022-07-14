import 'package:diadiemlongkhanh/models/remote/place_response/place_response.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlaceHorizItemView extends StatelessWidget {
  const PlaceHorizItemView({
    Key? key,
    required this.context,
    this.onPressed,
    this.item,
  }) : super(key: key);

  final BuildContext context;
  final PlaceModel? item;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRectImage(
              url: AppUtils.getUrlImage(
                item!.avatar?.path ?? '',
                width: 500,
                height: 500,
              ),
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
                  AppUtils.getOpeningTitle(item!.openingStatus ?? ''),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppUtils.getOpeningColor(item!.openingStatus ?? ''),
                  ),
                ),
                Text(
                  AppUtils.getDistance(item!.distance ?? 0) > 0
                      ? 'Cách ${AppUtils.getDistance(item!.distance ?? 0)}km '
                      : '',
                  style: TextStyle(
                    fontSize: 10,
                    color: ColorConstant.neutral_gray,
                  ),
                )
              ],
            ),
            Text(
              item!.name ?? '',
              maxLines: 2,
              textAlign: TextAlign.left,
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
                  item!.region?.name ?? '',
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
