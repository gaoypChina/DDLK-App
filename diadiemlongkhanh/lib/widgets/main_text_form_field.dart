import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainTextFormField extends StatelessWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? radius;
  final Color? colorBorder;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLines;
  final Color? fillColor;
  final bool hideBorder;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool readOnly;
  final TextCapitalization textCapitalization;

  MainTextFormField({
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.radius,
    this.colorBorder,
    this.keyboardType,
    this.contentPadding,
    this.maxLines,
    this.fillColor,
    this.hideBorder = false,
    this.onChanged,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.inputFormatters,
    this.maxLength,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.none,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyText1,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      onChanged: onChanged,
      controller: controller,
      obscureText: obscureText,
      maxLength: maxLength,
      validator: validator,
      readOnly: readOnly,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        counterText: "",
        fillColor: fillColor,
        filled: fillColor != null,
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
        contentPadding: contentPadding ?? const EdgeInsets.only(left: 16),
        border: hideBorder
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? 4),
                borderSide: BorderSide(
                  color: colorBorder ?? ColorConstant.border_gray,
                ),
              ),
        enabledBorder: hideBorder
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? 4),
                borderSide: BorderSide(
                  color: colorBorder ?? ColorConstant.border_gray,
                ),
              ),
        focusedBorder: hideBorder
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? 4),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
      ),
    );
  }
}
