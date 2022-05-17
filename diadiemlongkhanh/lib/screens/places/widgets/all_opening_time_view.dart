import 'package:diadiemlongkhanh/models/remote/place_response/place_response.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AllOpeningTimeView extends StatefulWidget {
  const AllOpeningTimeView({
    Key? key,
    this.openingTime,
  }) : super(key: key);
  final OpeningTimeModel? openingTime;

  @override
  State<AllOpeningTimeView> createState() => _AllOpeningTimeViewState();
}

class _AllOpeningTimeViewState extends State<AllOpeningTimeView> {
  List<_OpeningModel> _datas = [];
  @override
  void initState() {
    super.initState();
    _addData();
  }

  _addData() {
    if (widget.openingTime != null) {
      final openingTime = widget.openingTime!;
      _datas.add(
        _OpeningModel(
          title: 'Thứ 2',
          value: openingTime.mon,
          prefix: 'mon',
        ),
      );
      _datas.add(
        _OpeningModel(
          title: 'Thứ 3',
          value: openingTime.tue,
          prefix: 'tue',
        ),
      );
      _datas.add(
        _OpeningModel(
          title: 'Thứ 4',
          value: openingTime.wed,
          prefix: 'wed',
        ),
      );
      _datas.add(
        _OpeningModel(
          title: 'Thứ 5',
          value: openingTime.thu,
          prefix: 'thu',
        ),
      );
      _datas.add(
        _OpeningModel(
          title: 'Thứ 6',
          value: openingTime.fri,
          prefix: 'fri',
        ),
      );
      _datas.add(
        _OpeningModel(
          title: 'Thứ 7',
          value: openingTime.sat,
          prefix: 'sat',
        ),
      );
      _datas.add(
        _OpeningModel(
          title: 'Chủ nhật',
          value: openingTime.sun,
          prefix: 'sun',
        ),
      );
    }
  }

  bool isToday(String value) {
    final now = DateTime.now();
    final day = AppUtils.convertDateToString(now, format: 'EEE');
    return value == day.toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.6),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 56,
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
                        'Khung giờ mở cửa',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: SvgPicture.asset(ConstantIcons.ic_close),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                ListView.builder(
                  itemCount: _datas.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (_, index) {
                    final item = _datas[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 94,
                            height: 34,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: isToday(item.prefix ?? '')
                                  ? Theme.of(context).primaryColor
                                  : ColorConstant.neutral_gray_lightest,
                            ),
                            child: Center(
                              child: Text(
                                item.title ?? '',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: isToday(item.prefix ?? '')
                                      ? FontWeight.w500
                                      : null,
                                  color: isToday(item.prefix ?? '')
                                      ? Colors.white
                                      : ColorConstant.neutral_black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              item.value ?? '',
                              maxLines: 2,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 12,
                                color: ColorConstant.neutral_black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OpeningModel {
  String? title;
  String? value;
  String? prefix;
  _OpeningModel({
    this.title,
    this.prefix,
    this.value,
  });
}
