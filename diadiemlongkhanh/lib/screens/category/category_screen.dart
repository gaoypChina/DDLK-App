import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with AutomaticKeepAliveClientMixin {
  int _currentIndex = 0;
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: MyAppBar(
        title: 'Danh mục',
        isShowBackButton: false,
      ),
      body: ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        padding: const EdgeInsets.only(
          top: 36,
          left: 16,
          right: 16,
          bottom: 30,
        ),
        itemBuilder: (_, index) {
          return Container(
            height: 100,
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                width: index == _currentIndex ? 2 : 1,
                color: index == _currentIndex
                    ? Theme.of(context).primaryColor
                    : ColorConstant.neutral_gray_lightest,
              ),
              boxShadow: [
                BoxShadow(
                  color: ColorConstant.neutral_black.withOpacity(0.12),
                  offset: Offset(0, 8),
                  blurRadius: 20,
                )
              ],
            ),
            child: Row(
              children: [
                Container(
                  height: 90,
                  width: 90,
                  margin: const EdgeInsets.only(right: 48),
                  child: Center(
                    child: Image.asset(
                      ConstantIcons.ic_food,
                      width: 68,
                      height: 59,
                    ),
                  ),
                ),
                Text(
                  'Ăn uống',
                  style: Theme.of(context).textTheme.headline4?.apply(
                        color: index == _currentIndex
                            ? Theme.of(context).primaryColor
                            : null,
                      ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
