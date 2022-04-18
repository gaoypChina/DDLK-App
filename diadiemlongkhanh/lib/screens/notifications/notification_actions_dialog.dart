import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotificationActionsDialog extends StatelessWidget {
  const NotificationActionsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 178,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Thêm',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    SvgPicture.asset(
                      ConstantIcons.ic_close,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
