import 'package:diadiemlongkhanh/models/remote/slide/slide_response.dart';
import 'package:diadiemlongkhanh/screens/skeleton_view/shimmer_image.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:diadiemlongkhanh/widgets/dots_view.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class CustomSliderView extends StatefulWidget {
  final List<SlideModel> datas;

  CustomSliderView({
    required this.datas,
  });
  @override
  _CustomSliderViewState createState() => _CustomSliderViewState();
}

class _CustomSliderViewState extends State<CustomSliderView> {
  // final sliderDatas = [
  //   'https://aeonmall-haiphong-lechan.com.vn/wp-content/uploads/2020/12/hc-flagships-750x468-1.png',
  //   'https://kenh14cdn.com/thumb_w/600/203336854389633024/2021/10/1/photo1633091620833-16330916212291420799229.jpg',
  //   'https://phuclong.com.vn/uploads/store/83943c23fd8b7a-ntmk.jpg'
  // ];
  // List<SlideModel> sliderDatas = [];
  final cards = [
    MatchCard(Colors.green, 0),
    MatchCard(Colors.red, 0),
    MatchCard(Colors.blue, 12)
  ];
  List<Widget> cardList = [];
  int _indexSelected = 0;
  int _underIndexSelectd = 1;
  @override
  void initState() {
    super.initState();
  }

  swipedLeft() {
    if (_indexSelected == widget.datas.length - 1) {
      setState(() {
        _indexSelected = 0;
        _underIndexSelectd = 1;
      });
      return;
    }
    setState(() {
      _indexSelected += 1;
      if (_underIndexSelectd + 1 >= widget.datas.length) {
        _underIndexSelectd = _indexSelected - 1;
        return;
      }
      _underIndexSelectd = _underIndexSelectd + 1;
    });
  }

  swipeRight() {
    if (_indexSelected == 0) {
      setState(() {
        _indexSelected = widget.datas.length - 1;
        _underIndexSelectd = widget.datas.length - 2;
      });
      return;
    }
    setState(() {
      _indexSelected -= 1;
      // if (_underIndexSelectd - 1 <= _indexSelected) {
      //   return;
      // }
      if (_underIndexSelectd - 1 < 0) {
        _underIndexSelectd = _indexSelected + 1;
        return;
      }
      _underIndexSelectd = _underIndexSelectd - 1;
      print(_indexSelected);
      print(_underIndexSelectd);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 180,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: widget.datas.isEmpty
              ? ShimmerImage(
                  height: 180,
                )
              : Stack(
                  children: [
                    Positioned(
                      top: 6,
                      bottom: 6,
                      left: 0,
                      right: 0,
                      child: ClipRRectImage(
                        radius: 12,
                        url: AppUtils.getUrlImage(
                            widget.datas[_underIndexSelectd].photo?.path ?? ''),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 12,
                      right: 12,
                      child: Draggable(
                        axis: Axis.horizontal,
                        onDragEnd: (drag) {
                          print(drag.offset);
                          if (drag.offset.dx < 0) {
                            swipedLeft();
                          } else {
                            swipeRight();
                          }
                        },
                        childWhenDragging: Container(),
                        feedback: Container(
                          child: ClipRRectImage(
                            height: 180,
                            radius: 12,
                            url: AppUtils.getUrlImage(
                                widget.datas[_indexSelected].photo?.path ?? ''),
                          ),
                        ),
                        child: ClipRRectImage(
                          radius: 12,
                          url: AppUtils.getUrlImage(
                              widget.datas[_indexSelected].photo?.path ?? ''),
                        ),
                      ),
                    )
                  ],
                ),
        ),
        SizedBox(
          height: 12,
        ),
        widget.datas.isNotEmpty
            ? DotsView(
                step: _indexSelected,
                length: widget.datas.length,
              )
            : SizedBox.shrink(),
      ],
    );
  }
}

class MatchCard {
  Color color;
  double margin = 0;

  MatchCard(
    this.color,
    this.margin,
  );
}
