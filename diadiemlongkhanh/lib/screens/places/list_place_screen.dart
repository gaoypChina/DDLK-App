import 'package:diadiemlongkhanh/models/remote/category/category_response.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/screens/places/bloc/list_places_cubit.dart';
import 'package:diadiemlongkhanh/screens/places/widgets/places_grid_view.dart';
import 'package:diadiemlongkhanh/screens/search/search_screen.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/widgets/main_text_form_field.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'filter_place_screen.dart';
import 'widgets/filter_button.dart';

class ListPlaceScreen extends StatefulWidget {
  @override
  _ListPlaceScreenState createState() => _ListPlaceScreenState();
}

class _ListPlaceScreenState extends State<ListPlaceScreen> {
  ListPlacesCubit get _cubit => BlocProvider.of(context);
  final _debouncer = Debouncer(milliseconds: 500);
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _cubit.getCategories();
    _cubit.searchPlaces();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _cubit.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.grey_F2F4F8,
      appBar: MyAppBar(
        title: 'Danh sách địa điểm',
        actions: [
          BlocBuilder<ListPlacesCubit, ListPlacesState>(
            builder: (_, state) {
              int numFilter = 0;
              if (_cubit.dataSearch.nearby != '') {
                numFilter += 1;
              }
              if (_cubit.dataSearch.opening) {
                numFilter += 1;
              }
              if (_cubit.dataSearch.categories != null &&
                  _cubit.dataSearch.categories!.isNotEmpty) {
                numFilter += 1;
              }

              return FilterButton(
                numFilter: numFilter == 0 ? null : numFilter,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  AppUtils.showBottomDialog(
                    context,
                    FilterPlaceScreen(
                      categories: _cubit.categories,
                      searchData: _cubit.dataSearch,
                      complete: (val) {
                        _cubit.filterComplete(val);
                      },
                    ),
                  );
                },
              );
            },
          ),
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
                        maxLines: 1,
                        onChanged: (val) {
                          _debouncer.run(() {
                            print(val);
                            _cubit.searchKeyWord(val);
                          });
                        },
                      ),
                    ),
                    // Container(
                    //   margin: const EdgeInsets.symmetric(
                    //     vertical: 9,
                    //     horizontal: 16,
                    //   ),
                    //   width: 1,
                    //   color: ColorConstant.border_gray,
                    // ),
                    // Row(
                    //   children: [
                    //     SvgPicture.asset(
                    //       ConstantIcons.ic_gps,
                    //     ),
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    //     Text(
                    //       'Gần đây',
                    //       style: TextStyle(
                    //         fontSize: 14,
                    //         color: Theme.of(context).primaryColor,
                    //       ),
                    //     )
                    //   ],
                    // )
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<ListPlacesCubit, ListPlacesState>(
                  buildWhen: (previous, current) =>
                      current is ListPlacesGetDoneState,
                  builder: (_, state) {
                    if (_cubit.places.isEmpty) {
                      return _buildEmptyView();
                    }
                    return PlacesGridView(
                      controller: _scrollController,
                      topPadding: 12,
                      bottomPadding: 78,
                      places: _cubit.places,
                      onSelect: (item) => Navigator.of(context).pushNamed(
                        RouterName.detail_place,
                        arguments: item.id,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          _buildSeeMapButton(context)
        ]),
      ),
    );
  }

  Widget _buildEmptyView() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 30),
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Image.asset(
            ConstantImages.no_data,
            height: 188,
            width: 287,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Không tìm thấy kết quả tìm kiếm của bạn',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }

  Widget _buildSeeMapButton(BuildContext context) {
    return BlocBuilder<ListPlacesCubit, ListPlacesState>(
      buildWhen: (previous, current) => current is ListPlacesGetDoneState,
      builder: (_, state) {
        if (_cubit.places.isEmpty) {
          return SizedBox.shrink();
        }
        return Positioned.fill(
          bottom: 30,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                RouterName.map_places,
                arguments: _cubit.places,
              ),
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
          ),
        );
      },
    );
  }

  Widget _buildFilterButton(BuildContext context) {
    return FilterButton();
  }
}
