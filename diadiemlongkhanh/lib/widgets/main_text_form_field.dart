import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:flutter/material.dart';

class MainTextFormField extends StatelessWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? radius;
  final Color? colorBorder;
  MainTextFormField({
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.radius,
    this.colorBorder,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.subtitle1,
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: prefixIcon,
              )
            : null,
        prefixIconConstraints: BoxConstraints(
          minHeight: 20,
          minWidth: 20,
        ),
        suffixIconConstraints: BoxConstraints(
          minHeight: 20,
          minWidth: 20,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: suffixIcon,
        ),
        contentPadding: const EdgeInsets.only(left: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 4),
          borderSide: BorderSide(
            color: colorBorder ?? ColorConstant.border_gray,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 4),
          borderSide: BorderSide(
            color: colorBorder ?? ColorConstant.border_gray,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 4),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
