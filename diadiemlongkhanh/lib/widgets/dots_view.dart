import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:flutter/material.dart';

class DotsView extends StatelessWidget {
  const DotsView({
    Key? key,
    required this.step,
  }) : super(key: key);

  final int step;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      child: Center(
        child: ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              return Container(
                height: 8,
                width: step == index ? 31 : 8,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: step == index
                      ? ColorConstant.orange_secondary
                      : ColorConstant.neutral_gray_lightest,
                ),
              );
            }),
      ),
    );
  }
}
