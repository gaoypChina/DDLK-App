import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:diadiemlongkhanh/widgets/dots_view.dart';
import 'package:flutter/material.dart';

class CustomSliderView extends StatefulWidget {
  const CustomSliderView({Key? key}) : super(key: key);

  @override
  _CustomSliderViewState createState() => _CustomSliderViewState();
}

class _CustomSliderViewState extends State<CustomSliderView> {
  List<String> sliderDatas = [
    'https://aeonmall-haiphong-lechan.com.vn/wp-content/uploads/2020/12/hc-flagships-750x468-1.png',
    'https://kenh14cdn.com/thumb_w/600/203336854389633024/2021/10/1/photo1633091620833-16330916212291420799229.jpg',
  ];
  final _images = [
    'https://aeonmall-haiphong-lechan.com.vn/wp-content/uploads/2020/12/hc-flagships-750x468-1.png',
    'https://kenh14cdn.com/thumb_w/600/203336854389633024/2021/10/1/photo1633091620833-16330916212291420799229.jpg',
    'https://phuclong.com.vn/uploads/store/83943c23fd8b7a-ntmk.jpg'
  ];
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
    cardList = _getMatchCard();
  }

  swipedLeft() {
    if (_indexSelected == _images.length - 1) {
      return;
    }
    setState(() {
      _indexSelected += 1;
      if (_underIndexSelectd + 1 >= _images.length) {
        _underIndexSelectd = _indexSelected - 1;
        return;
      }
      _underIndexSelectd = _underIndexSelectd + 1;
    });
  }

  swipeRight() {
    if (_indexSelected == 0) {
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

  List<Widget> _getMatchCard() {
    for (int x = 0; x < 3; x++) {
      cardList.add(Positioned(
        left: cards[x].margin,
        right: cards[x].margin,
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
          feedback: Card(
            elevation: 0,
            color: cards[x].color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              width: 320,
              height: 180,
              child: Center(
                child: Text('123123123'),
              ),
            ),
          ),
          child: Card(
            elevation: 0,
            color: cards[x].color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              width: 320,
              height: 180,
            ),
          ),
        ),
      ));
    }

    return cardList;
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
          child: Stack(
            children: [
              Positioned(
                top: 6,
                bottom: 6,
                left: 0,
                right: 0,
                child: ClipRRectImage(
                  radius: 12,
                  url: _images[_underIndexSelectd],
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
                      url: _images[_indexSelected],
                    ),
                  ),
                  child: ClipRRectImage(
                    radius: 12,
                    url: _images[_indexSelected],
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
        DotsView(step: _indexSelected),
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
