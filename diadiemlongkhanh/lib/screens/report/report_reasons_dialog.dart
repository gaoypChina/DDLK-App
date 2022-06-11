import 'package:diadiemlongkhanh/models/local/report_type_model.dart';
import 'package:diadiemlongkhanh/resources/app_constant.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReportReasonsDialog extends StatefulWidget {
  const ReportReasonsDialog({
    Key? key,
    this.type = ReportType.review,
    this.docId,
  }) : super(key: key);
  final String type;
  final String? docId;

  @override
  State<ReportReasonsDialog> createState() => _ReportReasonsDialogState();
}

class _ReportReasonsDialogState extends State<ReportReasonsDialog> {
  List<String> reasons = [];
  final _desCtler = TextEditingController();
  @override
  void initState() {
    super.initState();
    getReportReasons();
  }

  _report(String reason) async {
    if (reason == 'Khác') {
      _displayTextInputDialog(
        context,
        reason,
      );
      return;
    }
    _desCtler.text = '';
    _sendReport(reason);
  }

  _sendReport(String reason) async {
    AppUtils.showLoading();
    final data = {
      "content": reason,
      "description": _desCtler.text,
      "docModel": widget.type,
      "doc": widget.docId,
    };
    final res = await injector.get<ApiClient>().report(data);
    AppUtils.hideLoading();
    if (res != null) {
      if (res.error != null) {
        AppUtils.showOkDialog(context, res.error!);
        return;
      }

      AppUtils.showSuccessAlert(
        context,
        title: 'Cảm ơn bạn đã gửi báo cáo, chúng tôi sẽ xem xét',
        okTitle: 'Xác nhận',
        okAction: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      );
      return;
    }
    AppUtils.showOkDialog(
      context,
      ConstantTitle.please_try_again,
    );
  }

  Future<void> _displayTextInputDialog(
    BuildContext context,
    String reason,
  ) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Nhập mô tả'),
          content: TextField(
            onChanged: (value) {},
            controller: _desCtler,
            decoration: InputDecoration(
              hintText: "Nội dung mô tả",
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: ColorConstant.border_gray,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: ColorConstant.border_gray,
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_desCtler.text == '') {
                  return;
                }
                Navigator.of(context).pop();
                _sendReport(reason);
              },
              child: Text(
                'Xác nhận',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Hủy bỏ',
                  style: TextStyle(
                    color: ColorConstant.neutral_gray,
                  ),
                ))
          ],
        );
      },
    );
  }

  getReportReasons() async {
    AppUtils.showLoading();
    final res = await injector
        .get<ApiClient>()
        .getReportReasons(widget.type.toLowerCase());
    AppUtils.hideLoading();
    if (res != null) {
      setState(() {
        reasons = res;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.6),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                          'Báo cáo',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: SvgPicture.asset(ConstantIcons.ic_close),
                        )
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  ListView.builder(
                    itemCount: reasons.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 15, bottom: 16),
                    itemBuilder: (_, index) {
                      return InkWell(
                        onTap: () => _report(reasons[index]),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            bottom: 16,
                          ),
                          child: Text(
                            reasons[index],
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      );
                    },
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
