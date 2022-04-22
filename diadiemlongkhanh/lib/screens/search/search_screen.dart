import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/screens/places/widgets/place_horiz_item_view.dart';
import 'package:diadiemlongkhanh/widgets/main_text_form_field.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:diadiemlongkhanh/widgets/search_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.grey_F2F4F8,
      appBar: MyAppBar(
        title: 'Tìm kiếm',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchView(),
            _buildHistorySearch(),
            _buildHotPlaces(),
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                left: 16,
              ),
              child: Text(
                'Gợi ý',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Container(
              height: 314,
              child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 16,
                  bottom: 40,
                ),
                itemBuilder: (_, index) {
                  return PlaceHorizItemView(
                    context: context,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _buildHotPlaces() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(ConstantIcons.ic_fire),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Địa điểm Hot',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
          Container(
            height: 52,
            margin: const EdgeInsets.only(
              top: 10,
            ),
            child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                  left: 16,
                  bottom: 16,
                ),
                itemBuilder: (_, index) {
                  return Container(
                    height: 36,
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Cà phê',
                          style: TextStyle(
                            fontSize: 12,
                            color: ColorConstant.neutral_black,
                          ),
                        ),
                        SvgPicture.asset(
                          ConstantIcons.ic_close,
                          color: ColorConstant.neutral_gray,
                          width: 16,
                          height: 16,
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Container _buildHistorySearch() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Tìm kiếm gần đây',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  'Xóa tất cả',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 52,
            margin: const EdgeInsets.only(
              top: 10,
            ),
            child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                  left: 16,
                  bottom: 16,
                ),
                itemBuilder: (_, index) {
                  return Container(
                    height: 36,
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Cà phê',
                          style: TextStyle(
                            fontSize: 12,
                            color: ColorConstant.neutral_black,
                          ),
                        ),
                        SvgPicture.asset(
                          ConstantIcons.ic_close,
                          color: ColorConstant.neutral_gray,
                          width: 16,
                          height: 16,
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Container _buildSearchView() {
    return Container(
      height: 48,
      margin: const EdgeInsets.only(
        top: 24,
        bottom: 12,
        left: 16,
        right: 16,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: ColorConstant.border_gray,
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            ConstantIcons.ic_search,
          ),
          Expanded(
            child: MainTextFormField(
              hideBorder: true,
              hintText: 'Nhập địa điểm cần tìm',
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 9,
              horizontal: 16,
            ),
            width: 1,
            color: ColorConstant.border_gray,
          ),
          Row(
            children: [
              SvgPicture.asset(
                ConstantIcons.ic_gps,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Gần đây',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
