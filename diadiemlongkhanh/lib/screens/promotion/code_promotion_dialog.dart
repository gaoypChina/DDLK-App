import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CodePromotionDialog extends StatefulWidget {
  const CodePromotionDialog({Key? key}) : super(key: key);

  @override
  _CodePromotionDialogState createState() => _CodePromotionDialogState();
}

class _CodePromotionDialogState extends State<CodePromotionDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 480,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 16,
                  right: 16,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: SvgPicture.asset(
                      ConstantIcons.ic_close,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 37,
                      ),
                      Text(
                        'Giảm giá 30%',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: ColorConstant.orange_secondary,
                        ),
                      ),
                      Text(
                        'Số lượng: 40',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      QrImage(
                        data: "1234567890",
                        padding: const EdgeInsets.all(0),
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 38),
                        child: Text(
                          'Chụp ảnh màn hình mã này và đến ngay cửa hàng để nhận ưu đãi bạn nhé',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(height: 1.7),
                        ),
                      ),
                      Container(
                        height: 64,
                        margin: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 12,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: ColorConstant.neutral_gray_lightest,
                        ),
                        child: Center(
                          child: Text(
                            'Cần đưa mã này cho Thu ngân/Cửa hàng để xác thực mã',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              color: ColorConstant.neutral_black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
