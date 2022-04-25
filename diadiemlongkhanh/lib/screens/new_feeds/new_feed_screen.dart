import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/screens/new_feeds/widgets/new_feed_item_view.dart';
import 'package:diadiemlongkhanh/screens/skeleton_view/skeletion_newfeeds.dart';

import 'package:flutter/material.dart';

class NewFeedScreen extends StatefulWidget {
  const NewFeedScreen({Key? key}) : super(key: key);

  @override
  _NewFeedScreenState createState() => _NewFeedScreenState();
}

class _NewFeedScreenState extends State<NewFeedScreen>
    with AutomaticKeepAliveClientMixin {
  List<String> filterDatas = ['Tất cả', 'Đang theo dõi'];
  int _indexFilter = 0;
  bool _isLoading = true;
  @override
  void initState() {
    print('newfeed');
    super.initState();
    _simulateLoad();
  }

  Future _simulateLoad() async {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.grey_F2F4F8,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                title: Text(
                  'Khám phá',
                  style: Theme.of(context).textTheme.headline3,
                ),
                automaticallyImplyLeading: false,
                pinned: false,
                floating: true,
                forceElevated: innerBoxIsScrolled,
              ),
              SliverToBoxAdapter(
                child: Container(
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
                              fontWeight: index == _indexFilter
                                  ? FontWeight.w500
                                  : FontWeight.w400,
                              color: index == _indexFilter
                                  ? Colors.white
                                  : ColorConstant.neutral_gray,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ];
          },
          body: _isLoading
              ? SkeletionNewFeeds()
              : ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(
                    top: 24,
                    bottom: 30,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return NewFeedItemView(
                      isShowComment: true,
                    );
                  },
                ),
        ),
      ),
    );
  }
}
