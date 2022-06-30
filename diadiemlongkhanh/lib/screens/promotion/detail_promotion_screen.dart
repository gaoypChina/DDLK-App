import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/screens/promotion/bloc/detail_promotion_cubit.dart';
import 'package:diadiemlongkhanh/screens/promotion/code_promotion_dialog.dart';
import 'package:diadiemlongkhanh/screens/promotion/widgets/list_promotion_view.dart';
import 'package:diadiemlongkhanh/screens/skeleton_view/shimmer_image.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/services/storage/storage_service.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:diadiemlongkhanh/widgets/line_dashed_painter.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class DetailPromotionScreen extends StatefulWidget {
  const DetailPromotionScreen({Key? key}) : super(key: key);

  @override
  State<DetailPromotionScreen> createState() => _DetailPromotionScreenState();
}

class _DetailPromotionScreenState extends State<DetailPromotionScreen> {
  DetailPromotionCubit get _cubit => BlocProvider.of(context);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _cubit.getDetailVoucher();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.grey_F2F4F8,
      appBar: MyAppBar(
        title: 'Chi tiết khuyến mãi',
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              bottom: 0,
              child: Image.asset(
                ConstantImages.left_pin,
                width: 153,
                height: 116,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<DetailPromotionCubit, DetailPromotionState>(
                      buildWhen: (previous, current) =>
                          current is DetailPromotionGetDoneState,
                      builder: (_, state) {
                        return Column(
                          children: [
                            _buildVoucherView(),
                            // _buildContentView(),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 16),
                    //   child: Text(
                    //     'Các khuyến mãi khác',
                    //     style: Theme.of(context).textTheme.headline5,
                    //   ),
                    // ),
                    // ListPromotionView(
                    //   margin: const EdgeInsets.only(top: 16),
                    //   vouhchers: [],
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _buildContentView() {
    return Container(
      margin: const EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 15),
            blurRadius: 40,
            color: ColorConstant.green_shadow.withOpacity(0.12),
          )
        ],
      ),
      child: Text(
        _cubit.voucher?.content ?? '',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  Container _buildVoucherView() {
    final voucher = _cubit.voucher;
    return Container(
      height: 500,
      child: Stack(
        children: [
          voucher == null
              ? ShimmerImage(
                  height: 286,
                )
              : ClipRRectImage(
                  radius: 8,
                  height: 286,
                  width: double.infinity,
                  url: AppUtils.getUrlImage(
                    voucher.thumbnail?.path ?? '',
                  ),
                ),
          Positioned(
            top: 250,
            left: 16,
            right: 16,
            child: Column(
              children: [
                Container(
                  height: 249,
                  child: Column(
                    children: [
                      Container(
                        height: 172,
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                          left: 16,
                          top: 16,
                          right: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, -4),
                              blurRadius: 8,
                              color:
                                  ColorConstant.green_shadow.withOpacity(0.12),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              voucher?.title ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: ColorConstant.orange_secondary,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              voucher?.place?.name ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            voucher == null
                                ? SizedBox.shrink()
                                : Row(
                                    children: [
                                      Expanded(
                                        flex: 7,
                                        child: InkWell(
                                          onTap: () {
                                            if (injector
                                                    .get<StorageService>()
                                                    .getToken() ==
                                                null) {
                                              Navigator.of(context).pushNamed(
                                                  RouterName.option_login,
                                                  arguments: true);
                                              return;
                                            }
                                            showDialog(
                                              context: context,
                                              builder: (_) =>
                                                  CodePromotionDialog(
                                                voucher: voucher,
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: 48,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  ConstantIcons.ic_qr,
                                                  height: 24,
                                                  width: 24,
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  'Lấy mã giảm giá',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4
                                                      ?.apply(
                                                        color: Colors.white,
                                                      ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      // Expanded(
                                      //   flex: 3,
                                      //   child: Container(
                                      //     height: 48,
                                      //     decoration: BoxDecoration(
                                      //       color:
                                      //           ColorConstant.neutral_gray_lightest,
                                      //       borderRadius: BorderRadius.circular(12),
                                      //     ),
                                      //     child: Center(
                                      //       child: Text(
                                      //         'Lưu',
                                      //         style: Theme.of(context)
                                      //             .textTheme
                                      //             .headline4,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  )
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        child: CustomPaint(
                          painter: LineDashedPainter(
                            isHorizontal: false,
                          ),
                        ),
                      ),
                      Container(
                        height: 76,
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 8),
                              blurRadius: 16,
                              color:
                                  ColorConstant.green_shadow.withOpacity(0.12),
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRectImage(
                              radius: 22,
                              url: AppUtils.getUrlImage(
                                voucher?.place?.avatar?.path ?? '',
                                width: 200,
                                height: 200,
                              ),
                              height: 44,
                              width: 44,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Expanded(
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => Navigator.of(context).pushNamed(
                                  RouterName.detail_place,
                                  arguments: voucher?.place?.id,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      voucher?.place?.name ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    // Row(
                                    //   children: [
                                    //     Text(
                                    //       '4.0',
                                    //       style: TextStyle(
                                    //         fontSize: 12,
                                    //         fontWeight: FontWeight.w500,
                                    //         color: ColorConstant
                                    //             .neutral_gray_lighter,
                                    //       ),
                                    //     ),
                                    //     SizedBox(
                                    //       width: 7,
                                    //     ),
                                    //     MyRatingBar(
                                    //       rating: 4,
                                    //       onRatingUpdate: (rate, isEmpty) {},
                                    //     ),
                                    //   ],
                                    // ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      'Mở cửa',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   width: 10,
                            // ),
                            // Container(
                            //   width: 98,
                            //   height: 28,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(14),
                            //     border: Border.all(
                            //         color: Theme.of(context).primaryColor),
                            //   ),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       SvgPicture.asset(
                            //         ConstantIcons.ic_book_mark,
                            //         width: 11,
                            //         height: 14,
                            //       ),
                            //       SizedBox(
                            //         width: 4,
                            //       ),
                            //       Text(
                            //         'Lưu địa điểm',
                            //         style: TextStyle(
                            //           fontSize: 10,
                            //           fontWeight: FontWeight.w500,
                            //           color: Theme.of(context).primaryColor,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
