import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/screens/welcome/model/welcome_model.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/services/storage/storage_service.dart';
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
  final scrollController = PageController();

  @override
  void initState() {
    super.initState();
    injector.get<StorageService>().setFirstInstall(false);
    scrollController.addListener(() {
      addListener();
    });
    controller = AnimationController(
      value: 0.5,
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
        print(controller.value);
      });
  }

  addListener() async {
    if (scrollController.page == 1.0 ||
        scrollController.page == 2.0 ||
        scrollController.page == 0.0) {
      final _step = scrollController.page?.round() ?? 0;

      setState(() {
        step = _step;
      });
    }
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
                    const SizedBox(
                      height: 142,
                    ),
                    SizedBox(
                      height: 353,
                      child: PageView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          controller: scrollController,
                          itemCount: WelcomeModel.welcomeDatas.length,
                          itemBuilder: (_, index) {
                            final item = WelcomeModel.welcomeDatas[index];
                            return Column(
                              children: [
                                item.img,
                                const SizedBox(
                                  height: 32,
                                ),
                                item.title != null
                                    ? Text(
                                        'Chào mừng bạn đến',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      )
                                    : const SizedBox.shrink(),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  item.subTitle,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Text(
                                  item.description,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    DotsView(
                      step: step,
                      length: 3,
                    ),
                    const SizedBox(
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
    final width = MediaQuery.of(context).size.width;

    controller.forward();
    setState(() {
      step += 1;
      scrollController.animateTo(
        width * step,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
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
              onPressed: () => Navigator.of(context)
                ..pushNamedAndRemoveUntil(
                    RouterName.base_tabbar, (route) => false),
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

  Widget _buildSkipButton() {
    return Visibility(
      visible: step == 1,
      child: Positioned(
        top: 0,
        right: 0,
        child: GestureDetector(
          onTap: () => Navigator.of(context)
            ..pushNamedAndRemoveUntil(RouterName.base_tabbar, (route) => false),
          child: Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  ConstantImages.skip_bg,
                ),
              ),
            ),
            child: Stack(
              children: [
                const Positioned(
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
        ),
      ),
    );
  }
}
