import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/screens/report/report_reasons_dialog.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlaceActionDiaglog extends StatelessWidget {
  const PlaceActionDiaglog({
    Key? key,
    this.docId,
  }) : super(key: key);
  final String? docId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 200,
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
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: ColorConstant.neutral_gray_lightest),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Thêm',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: SvgPicture.asset(ConstantIcons.ic_close),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    onTap: () => AppUtils.showBottomDialog(
                      context,
                      ReportReasonsDialog(
                        docId: docId,
                      ),
                    ),
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          SvgPicture.asset(ConstantIcons.ic_report),
                          SizedBox(
                            width: 13,
                          ),
                          Text(
                            'Báo cáo',
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
