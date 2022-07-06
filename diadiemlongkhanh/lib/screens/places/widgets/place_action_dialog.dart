import 'package:diadiemlongkhanh/models/local/report_type_model.dart';
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
    this.type = ReportType.place,
    this.showShare = false,
    this.onShare,
  }) : super(key: key);
  final String? docId;
  final String type;
  final bool showShare;
  final Function()? onShare;

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
                  _buildItemView(
                    context,
                    title: 'Báo cáo',
                    icon: ConstantIcons.ic_report,
                    onPressed: () => AppUtils.showBottomDialog(
                      context,
                      ReportReasonsDialog(
                        docId: docId,
                      ),
                    ),
                  ),
                  showShare
                      ? _buildItemView(
                          context,
                          title: 'Chia sẻ',
                          icon: ConstantIcons.ic_share,
                          onPressed: onShare,
                        )
                      : SizedBox.shrink()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  InkWell _buildItemView(
    BuildContext context, {
    required String title,
    required String icon,
    Function()? onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            SizedBox(
              width: 13,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText2,
            )
          ],
        ),
      ),
    );
  }
}
