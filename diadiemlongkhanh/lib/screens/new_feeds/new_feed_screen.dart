import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
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
  @override
  void initState() {
    print('newfeed');
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: ColorConstant.grey_F2F4F8,
      appBar: MyAppBar(
        title: 'Khám phá',
        isShowBackButton: false,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('Weight Tracker'),
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
        body: ListView.builder(
          itemCount: 100,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: index.isOdd ? Colors.white : Colors.black12,
              height: 100.0,
              child: Center(
                child: Text('$index', textScaleFactor: 5),
              ),
            );
          },
        ),
      ),
    );
  }
}
