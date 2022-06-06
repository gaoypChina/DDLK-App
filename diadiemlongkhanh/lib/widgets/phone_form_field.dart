import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneFormField extends StatelessWidget {
  const PhoneFormField({
    Key? key,
    this.controller,
    this.isBorder = false,
    this.height = 48,
  }) : super(key: key);
  final TextEditingController? controller;
  final bool isBorder;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.only(top: 56),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: ColorConstant.border_gray,
        ),
      ),
      child: Row(
        children: [
          // Text(
          //   'VN +84',
          //   style: Theme.of(context).textTheme.bodyText1,
          // ),
          // Icon(
          //   Icons.arrow_drop_down,
          //   color: ColorConstant.neutral_black,
          // ),
          // SizedBox(
          //   width: 12,
          // ),
          // Container(
          //   width: 1,
          //   height: 22,
          //   color: ColorConstant.border_gray2,
          // ),
          Expanded(
            child: TextFormField(
              controller: controller,
              style: Theme.of(context).textTheme.bodyText1,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              maxLength: 11,
              maxLines: 1,
              decoration: InputDecoration(
                counterText: "",
                hintStyle: Theme.of(context).textTheme.subtitle1,
                hintText: 'Số điện thoại',
                border: isBorder
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                          color: ColorConstant.border_gray,
                        ),
                      )
                    : InputBorder.none,
                focusedBorder: isBorder
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : InputBorder.none,
                enabledBorder: isBorder
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                          color: ColorConstant.border_gray,
                        ),
                      )
                    : InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}
