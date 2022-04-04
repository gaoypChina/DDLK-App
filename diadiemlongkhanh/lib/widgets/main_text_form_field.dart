import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:flutter/material.dart';

class MainTextFormField extends StatelessWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  MainTextFormField({
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.subtitle1,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: prefixIcon,
        ),
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
          borderSide: BorderSide(
            color: ColorConstant.border_gray,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorConstant.border_gray,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
