import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/screens/places/filter_place_screen.dart';
import 'package:diadiemlongkhanh/screens/places/widgets/places_grid_view.dart';
import 'package:diadiemlongkhanh/widgets/main_text_form_field.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ListPlaceScreen extends StatefulWidget {
  const ListPlaceScreen({Key? key}) : super(key: key);

  @override
  _ListPlaceScreenState createState() => _ListPlaceScreenState();
}

class _ListPlaceScreenState extends State<ListPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.grey_F2F4F8,
      appBar: MyAppBar(
        title: 'Danh sách địa điểm',
        isShowBgBackButton: false,
        actions: [
          _buildFilterButton(context),
        ],
      ),
      body: SafeArea(
        child: Stack(children: [
          Column(
            children: [
              Container(
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
              ),
              Expanded(
                child: PlacesGridView(
                  topPadding: 12,
                  bottomPadding: 78,
                ),
              ),
            ],
          ),
          Positioned.fill(
            bottom: 30,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 152,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstant.green_shadow.withOpacity(0.12),
                      offset: Offset(0, 15),
                      blurRadius: 30,
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      ConstantIcons.ic_map_outline,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Xem Bản đồ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.apply(color: Theme.of(context).primaryColor),
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  Widget _buildFilterButton(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
          opaque: false,
          pageBuilder: (context, animation, secondaryAnimation) =>
              const FilterPlaceScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 18),
        child: Row(
          children: [
            Container(
              width: 26,
              height: 28,
              child: Stack(
                children: [
                  Positioned(
                    top: 4,
                    left: 0,
                    child: SvgPicture.asset(
                      ConstantIcons.ic_filter,
                      width: 20,
                      height: 18,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: ColorConstant.sematic_red,
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '4',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 7,
            ),
            Text(
              'Lọc',
              style: Theme.of(context).textTheme.headline2,
            )
          ],
        ),
      ),
    );
  }
}
