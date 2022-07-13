import 'package:diadiemlongkhanh/models/local/report_type_model.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/screens/new_feeds/bloc/new_feed_cubit.dart';
import 'package:diadiemlongkhanh/screens/new_feeds/widgets/new_feed_item_view.dart';
import 'package:diadiemlongkhanh/screens/places/bloc/list_places_cubit.dart';
import 'package:diadiemlongkhanh/screens/places/widgets/place_action_dialog.dart';
import 'package:diadiemlongkhanh/screens/skeleton_view/shimmer_newfeed.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/services/storage/storage_service.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewFeedScreen extends StatefulWidget {
  const NewFeedScreen({
    Key? key,
    this.isBack = false,
  }) : super(key: key);
  final bool isBack;
  @override
  _NewFeedScreenState createState() => _NewFeedScreenState();
}

class _NewFeedScreenState extends State<NewFeedScreen>
    with AutomaticKeepAliveClientMixin {
  List<String> filterDatas = ['Tất cả', 'Đang theo dõi'];
  int _indexFilter = 0;

  NewFeedCubit get _cubit => BlocProvider.of(context);
  final _scrollController = ScrollController();
  final _smartController = RefreshController();
  @override
  void initState() {
    print('newfeed');
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _cubit.loadMoreReviews();
      }
    });
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _cubit.getNewFeeds();
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: ColorConstant.grey_F2F4F8,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.white,
                  title: Text(
                    'Khám phá',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  automaticallyImplyLeading: widget.isBack,
                  leading: widget.isBack
                      ? IconButton(
                          icon: SvgPicture.asset(
                            ConstantIcons.ic_chevron_left,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      : SizedBox.shrink(),
                  pinned: false,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                ),
                // SliverToBoxAdapter(
                //   child: _buildListFiltersView(context),
                // ),
              ];
            },
            body: BlocBuilder<NewFeedCubit, NewFeedState>(
              buildWhen: (previous, current) =>
                  current is NewFeedGetDoneState ||
                  current is NewFeedLoadingState,
              builder: (context, state) {
                _smartController.loadComplete();
                _smartController.refreshCompleted();
                return SmartRefresher(
                  controller: _smartController,
                  enablePullDown: true,
                  enablePullUp: true,
                  onLoading: _cubit.loadMoreReviews,
                  onRefresh: _cubit.onRefresh,
                  header: WaterDropMaterialHeader(),
                  footer: CustomFooter(
                    builder: (context, mode) {
                      Widget body;
                      if (mode == LoadStatus.idle) {
                        body = Text('');
                      } else if (mode == LoadStatus.loading) {
                        if (_cubit.isLast) {
                          _smartController.loadComplete();
                        }
                        body = CupertinoActivityIndicator();
                      } else if (mode == LoadStatus.failed) {
                        body = Text('');
                      } else if (mode == LoadStatus.canLoading) {
                        body = Text('');
                      } else {
                        body = Text('');
                      }
                      return Center(child: body);
                    },
                  ),
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount:
                        _cubit.newfeeds.isEmpty ? 5 : _cubit.newfeeds.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(
                      top: 24,
                      bottom: 30,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return _cubit.newfeeds.isEmpty
                          ? ShimmerNewFeed(context)
                          : index == _cubit.newfeeds.length
                              ? AppUtils.buildProgressIndicator(context)
                              : NewFeedItemView(
                                  item: _cubit.newfeeds[index],
                                  moreSelect: () => AppUtils.showBottomDialog(
                                    context,
                                    PlaceActionDiaglog(
                                      type: ReportType.review,
                                      docId: _cubit.newfeeds[index].id,
                                      showShare: true,
                                      onShare: () => _cubit
                                          .shareReview(_cubit.newfeeds[index]),
                                    ),
                                  ),
                                  nextToDetail: () =>
                                      Navigator.of(context).pushNamed(
                                    RouterName.detail_review,
                                    arguments: _cubit.newfeeds[index],
                                  ),
                                  sendComment: () => _cubit.sendComment(index),
                                  likePressed: () =>
                                      _cubit.likePost(context, index),
                                  isShowComment: injector
                                          .get<StorageService>()
                                          .getToken() !=
                                      null,
                                );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Container _buildListFiltersView(BuildContext context) {
    return Container(
      height: 28,
      margin: const EdgeInsets.only(
        top: 24,
        left: 16,
        right: 16,
      ),
      child: ListView.builder(
        itemCount: filterDatas.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return Container(
            height: 28,
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: index == _indexFilter
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
            ),
            child: Center(
              child: Text(
                filterDatas[index],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight:
                      index == _indexFilter ? FontWeight.w500 : FontWeight.w400,
                  color: index == _indexFilter
                      ? Colors.white
                      : ColorConstant.neutral_gray,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
