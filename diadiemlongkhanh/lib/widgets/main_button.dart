import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final Color? color;
  final String? title;
  final Color? textColor;
  final Function()? onPressed;
  final EdgeInsetsGeometry? margin;
  MainButton({
    this.color,
    this.title,
    this.textColor,
    this.onPressed,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.all(0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color ?? Theme.of(context).primaryColor,
          ),
          child: Center(
            child: Text(
              title ?? '',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: textColor ?? Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
