import 'package:carousel_slider/carousel_slider.dart';
import 'package:diadiemlongkhanh/models/remote/slide/slide_response.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
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
  int _indexSelected = 0;

  @override
  void initState() {
    super.initState();
  }

  _onSelect(SlideModel item) {
    if (widget.datas.isEmpty) {
      return;
    }
    if (item.docModel?.toLowerCase() == 'place') {
      Navigator.of(context).pushNamed(
        RouterName.detail_place,
        arguments: item.doc,
      );
    } else if (item.docModel?.toLowerCase() == 'review') {
      Navigator.of(context).pushNamed(
        RouterName.detail_review,
        arguments: item.doc,
      );
    } else if (item.docModel?.toLowerCase() == 'voucher') {
      Navigator.of(context).pushNamed(
        RouterName.detail_promotion,
        arguments: item.doc,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.datas.isEmpty ? 1 : widget.datas.length,
          options: CarouselOptions(
              height: 180,
              enlargeCenterPage: true,
              onPageChanged: (index, _) {
                setState(() {
                  _indexSelected = index;
                });
              }),
          itemBuilder: (context, index, realIndex) {
            return ClipRRectImage(
              height: 180,
              radius: 12,
              onPressed: () => _onSelect(widget.datas[index]),
              url: AppUtils.getUrlImage(
                widget.datas.isEmpty
                    ? ''
                    : widget.datas[index].photo?.path ?? '',
              ),
            );
          },
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
    // Column(
    //   children: [
    //     Container(
    //       height: 180,
    //       padding: const EdgeInsets.symmetric(
    //         horizontal: 16,
    //       ),
    //       child: widget.datas.isEmpty
    //           ? ShimmerImage(
    //               height: 180,
    //             )
    //           : Stack(
    //               children: [
    //                 Positioned(
    //                   top: 6,
    //                   bottom: 6,
    //                   left: 0,
    //                   right: 0,
    //                   child: ClipRRectImage(
    //                     radius: 12,
    //                     url: AppUtils.getUrlImage(
    //                         widget.datas[_underIndexSelectd].photo?.path ?? ''),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   top: 0,
    //                   bottom: 0,
    //                   left: 12,
    //                   right: 12,
    //                   child: Draggable(
    //                     axis: Axis.horizontal,
    //                     onDragEnd: (drag) {
    //                       print(drag.offset);
    //                       if (drag.offset.dx < 0) {
    //                         swipedLeft();
    //                       } else {
    //                         swipeRight();
    //                       }
    //                     },
    //                     childWhenDragging: Container(),
    //                     feedback: Container(
    //                       child: ClipRRectImage(
    //                         height: 180,
    //                         radius: 12,
    //                         url: AppUtils.getUrlImage(
    //                             widget.datas[_indexSelected].photo?.path ?? ''),
    //                       ),
    //                     ),
    //                     child: ClipRRectImage(
    //                       radius: 12,
    //                       onPressed: () =>
    //                           _onSelect(widget.datas[_indexSelected]),
    //                       url: AppUtils.getUrlImage(
    //                           widget.datas[_indexSelected].photo?.path ?? ''),
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             ),
    //     ),
    //     SizedBox(
    //       height: 12,
    //     ),

    //   ],
    // );
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
