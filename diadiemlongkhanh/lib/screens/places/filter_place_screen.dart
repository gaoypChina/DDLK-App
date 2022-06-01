import 'package:diadiemlongkhanh/models/remote/body_search/search_model.dart';
import 'package:diadiemlongkhanh/models/remote/category/category_response.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/utils/global_value.dart';
import 'package:diadiemlongkhanh/widgets/app_checkbox.dart';
import 'package:diadiemlongkhanh/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterPlaceScreen extends StatefulWidget {
  const FilterPlaceScreen({
    Key? key,
    this.categories,
    this.searchData,
    this.complete,
  }) : super(key: key);
  final List<CategoryModel>? categories;
  final SearchModel? searchData;
  final Function(SearchModel)? complete;
  @override
  _FilterPlaceScreenState createState() => _FilterPlaceScreenState();
}

class _FilterPlaceScreenState extends State<FilterPlaceScreen> {
  bool isGps = true;
  List<CategoryModel> _categories = [];

  double _maxSliderValue = 2000000;
  double _lowerValue = 0;
  double _upperValue = 2000000;

  bool _nearMe = false;
  bool _isOpening = false;
  List<String> _categoriesSelected = [];

  @override
  void initState() {
    super.initState();
    if (widget.searchData != null) {
      _nearMe = widget.searchData!.nearby == 'me';
      _isOpening = widget.searchData!.opening;
      _categoriesSelected = widget.searchData!.categories ?? [];
    }
    _categories = widget.categories ?? [];
  }

  resetFilter() {
    setState(() {
      _nearMe = false;
      _isOpening = true;
      _lowerValue = 0;
      _upperValue = 2000000;
      _categoriesSelected.clear();
    });
  }

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
                  GestureDetector(
                    onTap: resetFilter,
                    child: Text(
                      'Đặt lại',
                      style: Theme.of(context).textTheme.headline4?.apply(
                            color: Theme.of(context).primaryColor,
                          ),
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
                          _buildBoolFilter(
                            'Vị trí',
                            'Gần tôi nhất',
                            value: _nearMe,
                            onChanged: (val) {
                              if (GlobalValue.lat == null) {
                                AppUtils.showOkDialog(context,
                                    'Vui lòng cho phép ứng dụng truy cập địa điểm để thực hiện chức năng này');
                                return;
                              }
                              setState(() {
                                _nearMe = !_nearMe;
                              });
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          _buildBoolFilter(
                            'Trạng thái',
                            'Đang mở cửa',
                            value: _isOpening,
                            onChanged: (val) {
                              setState(() {
                                _isOpening = !_isOpening;
                              });
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Dịch vụ',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          _buildCategoriesView(),
                          Container(
                            height: 1,
                            color: ColorConstant.neutral_gray_lightest,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Giá: ${AppUtils.formatCurrency(_lowerValue.round())}₫ - ${AppUtils.formatCurrency(_upperValue.round())}₫',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              SfRangeSlider(
                                min: 0,
                                max: _maxSliderValue,
                                showLabels: true,
                                enableTooltip: true,
                                showTicks: true,
                                stepSize: 10000,
                                inactiveColor: ColorConstant.border_gray,
                                activeColor: Theme.of(context).primaryColor,
                                labelFormatterCallback: (dynamic actualValue,
                                    String formattedText) {
                                  return AppUtils.formatCurrency(
                                      int.parse(formattedText));
                                },
                                tooltipTextFormatterCallback:
                                    (dynamic actualValue,
                                        String formattedText) {
                                  final value = actualValue as double;
                                  return AppUtils.formatCurrency(value.round());
                                },
                                values: SfRangeValues(
                                  _lowerValue,
                                  _upperValue,
                                ),
                                onChanged: (SfRangeValues value) {
                                  setState(() {
                                    _lowerValue = value.start;
                                    _upperValue = value.end;
                                  });
                                },
                              ),
                            ],
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
                      onPressed: () {
                        if (widget.complete != null) {
                          widget.complete!(
                            SearchModel(
                              nearby: _nearMe ? 'me' : '',
                              opening: _isOpening,
                              categories: _categoriesSelected,
                              price:
                                  '${_lowerValue.round()}-${_upperValue.round()}',
                            ),
                          );
                        }
                        Navigator.of(context).pop();
                      },
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

  ListView _buildCategoriesView() {
    return ListView.builder(
      itemCount: _categories.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      itemBuilder: (_, index) {
        final item = _categories[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildCheckBoxView(
              item.name ?? '', _categoriesSelected.contains(item.id),
              onChanged: (val) {
            print(val);
            if (!val) {
              if (!_categoriesSelected.contains(item.id)) {
                setState(() {
                  _categoriesSelected.add(item.id ?? '');
                });
              }
            } else {
              setState(() {
                _categoriesSelected
                    .removeAt(_categoriesSelected.indexOf(item.id ?? ''));
              });
            }
          }),
        );
      },
    );
  }

  Widget _buildBoolFilter(
    String title,
    String titleFilter, {
    bool value = false,
    Function(bool)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(
          height: 12,
        ),
        _buildCheckBoxView(
          titleFilter,
          value,
          onChanged: onChanged,
        ),
        SizedBox(
          height: 28,
        ),
        Container(
          height: 1,
          color: ColorConstant.neutral_gray_lightest,
        ),
      ],
    );
  }

  Widget _buildCheckBoxView(
    String title,
    bool value, {
    bool isSquare = true,
    Function(bool)? onChanged,
  }) {
    return Row(
      children: [
        AppCheckbox(
          value: value,
          isSquare: isSquare,
          onChanged: onChanged,
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
