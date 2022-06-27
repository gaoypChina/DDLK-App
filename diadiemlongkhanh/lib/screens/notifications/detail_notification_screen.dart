import 'package:diadiemlongkhanh/models/remote/notification/notification_response.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:diadiemlongkhanh/widgets/main_button.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:flutter/material.dart';

class DetailNotificationScreen extends StatefulWidget {
  const DetailNotificationScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;
  @override
  _DetailNotificationScreenState createState() =>
      _DetailNotificationScreenState();
}

class _DetailNotificationScreenState extends State<DetailNotificationScreen> {
  NotificationModel? _noti;
  @override
  void initState() {
    super.initState();
    _getDetail();
  }

  _getDetail() async {
    AppUtils.showLoading();
    final res = await injector.get<ApiClient>().getNotification(widget.id);
    AppUtils.hideLoading();
    if (res != null) {
      if (res.error != null) {
        AppUtils.showOkDialog(context, res.error!.message ?? '',
            okAction: () => Navigator.of(context).pop());
        return;
      }
      setState(() {
        _noti = res;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.grey_F2F4F8,
      appBar: MyAppBar(
        title: 'Thông báo',
      ),
      body: _noti == null
          ? SizedBox.shrink()
          : Container(
              height: double.infinity,
              child: Stack(
                children: [
                  ClipRRectImage(
                    height: 225,
                    width: double.infinity,
                    url: AppUtils.getUrlImage(
                      _noti!.thumbnail?.path ?? '',
                      height: 255,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 198),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 8),
                                  blurRadius: 20,
                                  color: ColorConstant.neutral_black
                                      .withOpacity(0.12),
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 52,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color:
                                            ColorConstant.neutral_gray_lightest,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          _noti!.title ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                      ),
                                      Text(
                                        AppUtils.convertDatetimePrefix(
                                            _noti!.sendTime ?? ''),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    _noti!.body ?? '',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24),
                          // MainButton(
                          //   title: 'KHÁM PHÁ THÊM',
                          // )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
