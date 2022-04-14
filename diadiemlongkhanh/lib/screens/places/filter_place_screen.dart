import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FilterPlaceScreen extends StatefulWidget {
  const FilterPlaceScreen({Key? key}) : super(key: key);

  @override
  _FilterPlaceScreenState createState() => _FilterPlaceScreenState();
}

class _FilterPlaceScreenState extends State<FilterPlaceScreen> {
  bool isGps = true;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Container(
        margin: EdgeInsets.only(top: width / 3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(color: ColorConstant.neutral_gray_lightest),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: SvgPicture.asset(ConstantIcons.ic_close),
                  ),
                  Text(
                    'Bộ lọc',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    'Đặt lại',
                    style: Theme.of(context).textTheme.headline4?.apply(
                          color: Theme.of(context).primaryColor,
                        ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 18,
                          ),
                          Text(
                            'Vị trí',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          _buildCheckBoxView('Gần tôi nhất'),
                          SizedBox(
                            height: 28,
                          ),
                          Container(
                            height: 1,
                            color: ColorConstant.neutral_gray_lightest,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Dịch vụ',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          _buildCheckBoxView('Ăn uống'),
                          SizedBox(
                            height: 12,
                          ),
                          _buildCheckBoxView('Nhà hàng'),
                          SizedBox(
                            height: 12,
                          ),
                          _buildCheckBoxView('Khách sạn'),
                          SizedBox(
                            height: 12,
                          ),
                          _buildCheckBoxView('Du lịch'),
                          SizedBox(
                            height: 12,
                          ),
                          _buildCheckBoxView('Spa'),
                          SizedBox(
                            height: 24,
                          ),
                          Container(
                            height: 1,
                            color: ColorConstant.neutral_gray_lightest,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Quan tâm nhiều',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          _buildCheckBoxView(
                            'Giảm dần',
                            isSquare: false,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          _buildCheckBoxView(
                            'Tăng dần',
                            isSquare: false,
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Container(
                            height: 1,
                            color: ColorConstant.neutral_gray_lightest,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Quan tâm nhiều',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          _buildCheckBoxView(
                            'Giảm dần',
                            isSquare: false,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          _buildCheckBoxView(
                            'Tăng dần',
                            isSquare: false,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      margin: const EdgeInsets.only(
                        top: 37,
                        bottom: 24,
                      ),
                      color: ColorConstant.neutral_gray_lightest,
                    ),
                    MainButton(
                      title: 'Xác nhận',
                      margin: const EdgeInsets.only(
                        bottom: 24,
                        left: 16,
                        right: 16,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCheckBoxView(
    String title, {
    bool isSquare = true,
  }) {
    return Row(
      children: [
        AppCheckbox(
          value: isGps,
          isSquare: isSquare,
          onChanged: (val) {
            setState(() {
              isGps = !isGps;
            });
          },
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }
}

class AppCheckbox extends StatelessWidget {
  final bool value;
  final bool disabled;
  final double size;
  final bool isSquare;
  final Function(bool)? onChanged;

  AppCheckbox({
    this.size = 20,
    this.value = false,
    this.disabled = false,
    this.isSquare = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final backColor = disabled ? Colors.grey : Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: () {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isSquare
              ? value
                  ? backColor
                  : Colors.transparent
              : Colors.transparent,
          borderRadius: isSquare
              ? BorderRadius.circular(4)
              : BorderRadius.circular(size / 2),
          border: Border.all(
            width: isSquare ? 1 : 2,
            color: value
                ? isSquare
                    ? Colors.transparent
                    : Theme.of(context).primaryColor
                : ColorConstant.neutral_gray_lighter,
          ),
        ),
        child: Center(
          child: value
              ? isSquare
                  ? SvgPicture.asset(
                      ConstantIcons.ic_check,
                    )
                  : Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: backColor,
                      ),
                    )
              : SizedBox.shrink(),
        ),
      ),
    );
  }
}
