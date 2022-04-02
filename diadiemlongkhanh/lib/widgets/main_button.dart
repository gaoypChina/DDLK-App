import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final Color? color;
  final String? title;
  final Color? textColor;
  final Function()? onPressed;
  MainButton({
    this.color,
    this.title,
    this.textColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color,
        ),
        child: Center(
          child: Text(
            title ?? '',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
