import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/widgets/dots_view.dart';
import 'package:diadiemlongkhanh/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  int step = 0;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      value: 0.5,
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
        print(controller.value);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              _buildSkipButton(),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 142,
                    ),
                    Image.asset(
                      ConstantImages.welcome1,
                      width: 250,
                      height: 194,
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Text(
                      'Chào mừng bạn đến',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Địa Điểm Long Khánh',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Mong muốn mang lại những điều hữu ích, những trải \nnghiệm tốt đẹp khi đến Long Khánh - Đồng Nai',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    DotsView(step: step),
                    SizedBox(
                      height: 58,
                    ),
                    _buildNextButton()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _nextTapped() async {
    if (step == 2) {
      return;
    }
    controller.forward();
    setState(() {
      step += 1;
    });
  }

  Widget _buildNextButton() {
    return GestureDetector(
      onTap: _nextTapped,
      child: step != 2
          ? Container(
              height: 68,
              width: 68,
              margin: const EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(34),
              ),
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      right: 0,
                      bottom: 0,
                      left: 0,
                      child: CircularProgressIndicator(
                        value: controller.value,
                        strokeWidth: 2,
                        backgroundColor: ColorConstant.neutral_gray_lightest,
                        color: Theme.of(context).primaryColor,
                      )),
                  Positioned(
                    top: 6,
                    right: 6,
                    bottom: 6,
                    left: 6,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          ConstantIcons.ic_arrow_right,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : MainButton(
              margin: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 30,
              ),
              color: Theme.of(context).primaryColor,
              title: 'KHÁM PHÁ NGAY',
              textColor: Colors.white,
            ),
    );
  }

  Positioned _buildSkipButton() {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              ConstantImages.skip_bg,
            ),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 16,
              right: 16,
              child: Text(
                'Skip',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
