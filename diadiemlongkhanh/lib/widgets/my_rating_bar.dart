import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;

class MyRatingBar extends StatelessWidget {
  final double rating;
  final Function(int, bool) onRatingUpdate;
  final Widget? emptyStar;
  final Widget? fillStar;
  MyRatingBar({
    this.rating = 0,
    required this.onRatingUpdate,
    this.emptyStar,
    this.fillStar,
  });

  @override
  Widget build(BuildContext context) {
    final list = listStars();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: list,
    );
  }

  List<Widget> listStars() {
    var list = [
      _buildRatingStar(0),
      _buildRatingStar(1),
      _buildRatingStar(2),
      _buildRatingStar(3),
      _buildRatingStar(4),
    ];
    final point = AppUtils.roundedRating(rating);
    if (point == 0.5) {
      list[0] = _buildRatingStar(
        0,
        isEmpty: false,
        isHalf: true,
      );
    } else if (point == 1) {
      list[0] = _buildRatingStar(
        0,
        isEmpty: false,
      );
    } else if (point == 1.5) {
      list[0] = _buildRatingStar(
        0,
        isEmpty: false,
      );
      list[1] = _buildRatingStar(
        1,
        isEmpty: false,
        isHalf: true,
      );
    } else if (point == 2) {
      list[0] = _buildRatingStar(
        0,
        isEmpty: false,
      );
      list[1] = _buildRatingStar(
        1,
        isEmpty: false,
      );
    } else if (point == 2.5) {
      list[0] = _buildRatingStar(
        0,
        isEmpty: false,
      );
      list[1] = _buildRatingStar(
        1,
        isEmpty: false,
      );
      list[2] = _buildRatingStar(
        2,
        isEmpty: false,
        isHalf: true,
      );
    } else if (point == 3) {
      list[0] = _buildRatingStar(
        0,
        isEmpty: false,
      );
      list[1] = _buildRatingStar(
        1,
        isEmpty: false,
      );
      list[2] = _buildRatingStar(
        2,
        isEmpty: false,
      );
    } else if (point == 3.5) {
      list[0] = _buildRatingStar(
        0,
        isEmpty: false,
      );
      list[1] = _buildRatingStar(
        1,
        isEmpty: false,
      );
      list[2] = _buildRatingStar(
        2,
        isEmpty: false,
      );
      list[3] = _buildRatingStar(
        3,
        isEmpty: false,
        isHalf: true,
      );
    } else if (point == 4) {
      list[0] = _buildRatingStar(
        0,
        isEmpty: false,
      );
      list[1] = _buildRatingStar(
        1,
        isEmpty: false,
      );
      list[2] = _buildRatingStar(
        2,
        isEmpty: false,
      );
      list[3] = _buildRatingStar(
        3,
        isEmpty: false,
      );
    } else if (point == 4.5) {
      list[0] = _buildRatingStar(
        0,
        isEmpty: false,
      );
      list[1] = _buildRatingStar(
        1,
        isEmpty: false,
      );
      list[2] = _buildRatingStar(
        2,
        isEmpty: false,
      );
      list[3] = _buildRatingStar(
        3,
        isEmpty: false,
      );
      list[4] = _buildRatingStar(
        4,
        isEmpty: false,
        isHalf: true,
      );
    } else if (point == 5) {
      list[0] = _buildRatingStar(
        0,
        isEmpty: false,
      );
      list[1] = _buildRatingStar(
        1,
        isEmpty: false,
      );
      list[2] = _buildRatingStar(
        2,
        isEmpty: false,
      );
      list[3] = _buildRatingStar(
        3,
        isEmpty: false,
      );
      list[4] = _buildRatingStar(
        4,
        isEmpty: false,
      );
    }

    return list;
  }

  Widget _buildRatingStar(
    int index, {
    bool isEmpty = true,
    bool isHalf = false,
  }) {
    return InkWell(
      onTap: () {
        onRatingUpdate(index + 1, isEmpty);
      },
      child: emptyStar != null && fillStar != null
          ? (isEmpty ? emptyStar : fillStar)
          : SvgPicture.asset(
              isEmpty
                  ? ConstantIcons.ic_empty_star
                  : isHalf
                      ? ConstantIcons.ic_half_star
                      : ConstantIcons.ic_fill_star,
              width: 11,
              height: 10,
            ),
    );
  }

  // Widget _buildNoRatingStar() {
  //   return Container(
  //     width: 28,
  //     height: 28,
  //     padding: EdgeInsets.all(5),
  //     margin: const EdgeInsets.only(left: 2),
  //     decoration:
  //         BoxDecoration(color: Color(0x40E4E4E4), shape: BoxShape.circle),
  //     child: Container(
  //       child: Image.asset('assets/images/ic_heart_off.png'),
  //     ),
  //   );
  // }
}
