import 'dart:async';

import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/screens/places/filter_place_screen.dart';
import 'package:diadiemlongkhanh/screens/places/widgets/filter_button.dart';
import 'package:diadiemlongkhanh/screens/places/widgets/place_horiz_item_view.dart';
import 'package:diadiemlongkhanh/screens/search/bloc/search_cubit.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:diadiemlongkhanh/widgets/main_text_form_field.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:diadiemlongkhanh/widgets/my_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchCubit get _cubit => BlocProvider.of(context);
  final _searchController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 1000);
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _cubit.getPlacesHot();
      _cubit.getHistorySearch();
      _cubit.getSubCategories();
      _cubit.getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: ColorConstant.grey_F2F4F8,
        appBar: MyAppBar(
          title: 'Tìm kiếm',
          actions: [
            BlocBuilder<SearchCubit, SearchState>(
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchView(),
              BlocBuilder<SearchCubit, SearchState>(
                buildWhen: (previous, current) =>
                    current is SearchGetPlacesDoneState ||
                    current is SearchClearKeyWordDoneState,
                builder: (_, state) {
                  if (state is SearchGetPlacesDoneState) {
                    return _buildListPlaceView();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        child: BlocBuilder<SearchCubit, SearchState>(
                          buildWhen: (previous, current) =>
                              current is SearchPlacesGetHotDoneState,
                          builder: (_, state) {
                            return ListView.builder(
                              itemCount: _cubit.hotPlaces.length,
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
                                  item: _cubit.hotPlaces[index],
                                  onPressed: () =>
                                      Navigator.of(context).pushNamed(
                                    RouterName.detail_place,
                                    arguments: _cubit.hotPlaces[index].id,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
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

  Widget _buildListPlaceView() {
    return Container(
      color: Colors.white,
      child: _cubit.places.isEmpty
          ? _buildEmptyView()
          : ListView.builder(
              itemCount: _cubit.places.length + (_cubit.isLast ? 0 : 1),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              itemBuilder: (_, index) {
                if (index == _cubit.places.length) {
                  return GestureDetector(
                    onTap: () => _cubit.loadMore(),
                    child: Text(
                      'Tải thêm',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor),
                    ),
                  );
                }
                final item = _cubit.places[index];
                return InkWell(
                  onTap: () {
                    _cubit.saveHistorySearch(_searchController.text);
                    Navigator.of(context).pushNamed(
                      RouterName.detail_place,
                      arguments: item.id,
                    );
                  },
                  child: Container(
                    height: 112,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstant.green_shadow.withOpacity(0.12),
                          offset: Offset(0, 15),
                          blurRadius: 40,
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRectImage(
                          width: 96,
                          height: double.infinity,
                          radius: 8,
                          url: AppUtils.getUrlImage(
                            item.avatar?.path ?? '',
                            width: 250,
                            height: 250,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                item.address?.specific ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ColorConstant.neutral_gray,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  Text(
                                    AppUtils.roundedRating(item.avgRate ?? 0)
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstant.neutral_gray_lighter,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  MyRatingBar(
                                    rating: item.avgRate ?? 0,
                                    onRatingUpdate: (rate, isEmpty) {},
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  Text(
                                    AppUtils.getOpeningTitle(
                                        item.openingStatus ?? ''),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildHotPlaces() {
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (previous, current) =>
          current is SearchGetSubCategoriesDoneState,
      builder: (_, state) {
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
                    itemCount: _cubit.subCategories.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(
                      left: 16,
                      bottom: 16,
                    ),
                    itemBuilder: (_, index) {
                      final item = _cubit.subCategories[index];
                      return GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                          RouterName.list_places,
                          arguments: {'sub_category': item},
                        ),
                        child: Container(
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
                                item.name ?? '',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ColorConstant.neutral_black,
                                ),
                              ),
                              // SvgPicture.asset(
                              //   ConstantIcons.ic_close,
                              //   color: ColorConstant.neutral_gray,
                              //   width: 16,
                              //   height: 16,
                              // )
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildHistorySearch() {
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (previous, current) => current is SearchGetHistoryDoneState,
      builder: (_, state) {
        List<String> keywords = [];
        if (state is SearchGetHistoryDoneState) {
          keywords = state.keyWords;
        }
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
                    keywords.isEmpty
                        ? SizedBox.shrink()
                        : GestureDetector(
                            onTap: () => _cubit.deleteAllKeyWords(),
                            child: Text(
                              'Xóa tất cả',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).primaryColor,
                              ),
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
                  itemCount: keywords.length,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(
                    left: 16,
                    bottom: 16,
                  ),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        _searchController.text = keywords[index];
                        _cubit.searchKeyWord(_searchController.text);
                      },
                      child: Container(
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
                              keywords[index],
                              style: TextStyle(
                                fontSize: 12,
                                color: ColorConstant.neutral_black,
                              ),
                            ),
                            SizedBox(
                              width: 14,
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () =>
                                  _cubit.deleteKeyWord(keywords[index]),
                              child: SvgPicture.asset(
                                ConstantIcons.ic_close,
                                color: ColorConstant.neutral_gray,
                                width: 16,
                                height: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchView() {
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
              controller: _searchController,
              maxLines: 1,
              hintText: 'Nhập địa điểm cần tìm',
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
    );
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
