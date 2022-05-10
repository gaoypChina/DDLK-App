import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: ColorConstant.grey_F2F4F8,
        appBar: MyAppBar(
          title: 'Tìm kiếm',
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
                    ],
                  );
                },
              ),

              // Container(
              //   height: 314,
              //   child: ListView.builder(
              //     itemCount: 5,
              //     shrinkWrap: true,
              //     scrollDirection: Axis.horizontal,
              //     padding: const EdgeInsets.only(
              //       top: 16,
              //       left: 16,
              //       bottom: 40,
              //     ),
              //     itemBuilder: (_, index) {
              //       return PlaceHorizItemView(
              //         context: context,
              //       );
              //     },
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListPlaceView() {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: _cubit.places.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, index) {
          final item = _cubit.places[index];
          return Container(
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
                    width: 96,
                    height: 96,
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
                            AppUtils.getOpeningTitle(item.openingStatus ?? ''),
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
          );
        },
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
                  itemCount: keywords.length,
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
                            keywords[index],
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
                  },
                ),
              )
            ],
          ),
        );
      },
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
              maxLines: 1,
              onChanged: (val) {
                _cubit.searchKeyWord(val);
              },
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
