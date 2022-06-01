import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppCheckbox extends StatelessWidget {
  final bool value;
  final bool disabled;
  final double size;
  final bool isSquare;
  final Function(bool)? onChanged;

  AppCheckbox({
    this.size = 20,
    this.value = false,
    this.disabled = false,
    this.isSquare = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final backColor = disabled ? Colors.grey : Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: () {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isSquare
              ? value
                  ? backColor
                  : Colors.transparent
              : Colors.transparent,
          borderRadius: isSquare
              ? BorderRadius.circular(4)
              : BorderRadius.circular(size / 2),
          border: Border.all(
            width: isSquare ? 1 : 2,
            color: value
                ? isSquare
                    ? Colors.transparent
                    : Theme.of(context).primaryColor
                : ColorConstant.neutral_gray_lighter,
          ),
        ),
        child: Center(
          child: value
              ? isSquare
                  ? SvgPicture.asset(
                      ConstantIcons.ic_check,
                    )
                  : Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: backColor,
                      ),
                    )
              : SizedBox.shrink(),
        ),
      ),
    );
  }
}
