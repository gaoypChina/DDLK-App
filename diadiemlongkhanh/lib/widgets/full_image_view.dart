import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FullImageView extends StatefulWidget {
  final List<String> urls;
  final int currentIndex;
  FullImageView(
    this.urls, {
    this.currentIndex = 0,
  });

  @override
  State<FullImageView> createState() => _FullImageViewState();
}

class _FullImageViewState extends State<FullImageView> {
  final _controller = PageController();
  late int _currentIndex;
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (widget.currentIndex != 0) {
        final width = MediaQuery.of(context).size.width;
        _controller.animateTo(
          width * widget.currentIndex,
          duration: Duration(milliseconds: 100),
          curve: Curves.linear,
        );
      }
      _controller.addListener(() {
        final width = MediaQuery.of(context).size.width - 40;
        if (_controller.position.pixels.toInt() % width.toInt() <= 10) {
          setState(() {
            _currentIndex = (_controller.position.pixels / width).round();
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 20,
              right: 20,
              left: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_currentIndex + 1}/${widget.urls.length}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          ConstantIcons.ic_close,
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 100,
              bottom: 100,
              left: 20,
              right: 20,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 200,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: widget.urls.length,
                  itemBuilder: (_, index) {
                    final item = AppUtils.getUrlImage(widget.urls[index]);
                    return InteractiveViewer(
                      boundaryMargin: EdgeInsets.all(0),
                      minScale: 1,
                      maxScale: 2,
                      panEnabled: true,
                      child: FadeInImage.assetNetwork(
                        placeholderFit: BoxFit.contain,
                        placeholder: ConstantImages.placeholder2,
                        fadeInDuration: Duration(milliseconds: 100),
                        fadeOutDuration: Duration(milliseconds: 100),
                        image: item,
                        fit: BoxFit.contain,
                        imageErrorBuilder: (context, exception, stackTrace) {
                          return Image.asset(
                            ConstantImages.ddlk_no_color,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
