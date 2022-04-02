import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:flutter/material.dart';

class SegmentLoginView extends StatefulWidget {
  final Function(int)? onChanged;
  SegmentLoginView({this.onChanged});
  @override
  _SegmentLoginViewState createState() => _SegmentLoginViewState();
}

class _SegmentLoginViewState extends State<SegmentLoginView> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: ColorConstant.border_gray,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 100),
            left: index == 0 ? 12 : (width - 32) / 2,
            top: 10,
            bottom: 10,
            right: index == 0 ? (width - 32) / 2 : 12,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: ColorConstant.neutral_gray,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        index = 0;
                        if (widget.onChanged != null) {
                          widget.onChanged!(index);
                        }
                      });
                    },
                    child: Text(
                      'Điện thoại',
                      textAlign: TextAlign.center,
                      style: index == 0
                          ? Theme.of(context)
                              .textTheme
                              .headline2
                              ?.apply(color: Colors.white)
                          : Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        index = 1;
                        if (widget.onChanged != null) {
                          widget.onChanged!(index);
                        }
                      });
                    },
                    child: Text(
                      'Email',
                      textAlign: TextAlign.center,
                      style: index == 1
                          ? Theme.of(context)
                              .textTheme
                              .headline2
                              ?.apply(color: Colors.white)
                          : Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
