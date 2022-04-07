import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyRatingBar extends StatelessWidget {
  final int rating;
  final Function(int, bool) onRatingUpdate;
  MyRatingBar({
    this.rating = 0,
    required this.onRatingUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final list = listStars();
    return Row(
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
    switch (rating) {
      case 1:
        list[0] = _buildRatingStar(
          0,
          isEmpty: false,
        );
        break;
      case 2:
        list[0] = _buildRatingStar(
          0,
          isEmpty: false,
        );
        list[1] = _buildRatingStar(
          1,
          isEmpty: false,
        );
        break;
      case 3:
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
        break;
      case 4:
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
        break;
      case 5:
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
        break;
    }
    return list;
  }

  Widget _buildRatingStar(
    int index, {
    bool isEmpty = true,
  }) {
    return InkWell(
      onTap: () {
        onRatingUpdate(index + 1, isEmpty);
      },
      child: SvgPicture.asset(
        isEmpty ? ConstantIcons.ic_empty_star : ConstantIcons.ic_fill_star,
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
