import 'package:diadiemlongkhanh/app/app_profile_cubit.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/screens/new_feeds/widgets/new_feed_item_view.dart';
import 'package:diadiemlongkhanh/screens/profile/bloc/account_cubit.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/utils/global_value.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:diadiemlongkhanh/widgets/verified_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with AutomaticKeepAliveClientMixin {
  AccountCubit get _cubit => BlocProvider.of(context);
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _cubit.loadMoreReviews();
      }
    });
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _cubit.getInfoUser();
      _cubit.getUserStats();
      _cubit.getReviewsOfUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<AppProfileCubit, AppProfileState>(
          listenWhen: (previous, current) => current is AppProfileUpdateState,
          listener: (context, state) {
            if (state is AppProfileUpdateState) {
              _cubit.getInfoUser();
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: ColorConstant.grey_F2F4F8,
        appBar: MyAppBar(
          title: 'Thông tin cá nhân',
          isShowBackButton: _cubit.userId != null,
          actions: [
            _cubit.userId != null
                ? SizedBox()
                // ? IconButton(
                //     onPressed: () => AppUtils.showBottomDialog(
                //       context,
                //       PlaceActionDiaglog(),
                //     ),
                //     icon: Icon(
                //       Icons.more_horiz,
                //       color: Colors.black,
                //     ),
                //   )
                : IconButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(RouterName.setting),
                    icon: SvgPicture.asset(
                      ConstantIcons.ic_setting,
                    ),
                  )
          ],
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              _buildInfoUserView(context),
              _cubit.userId == GlobalValue.id || _cubit.userId == null
                  ? _buildShowSavedBtn(context)
                  : _buildFollowView(context),
              BlocBuilder<AccountCubit, AccountState>(
                buildWhen: (previous, current) =>
                    current is AccountGetStatsDoneState,
                builder: (_, state) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 32,
                      right: 16,
                      left: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '${_cubit.stats?.countReviews ?? 0} ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              TextSpan(
                                text: 'Đánh giá',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Mới nhất',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            SvgPicture.asset(ConstantIcons.ic_chevron_down)
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
              BlocBuilder<AccountCubit, AccountState>(
                buildWhen: (previous, current) =>
                    current is AccountGetReviewsDoneState ||
                    current is AccountLoadingState,
                builder: (_, state) {
                  bool isLoading = false;
                  if (state is AccountLoadingState) {
                    isLoading = true;
                  }
                  return ListView.builder(
                    itemCount: _cubit.reviews.length + (isLoading ? 1 : 0),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(
                      top: 24,
                      bottom: 30,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == _cubit.reviews.length) {
                        return AppUtils.buildProgressIndicator(context);
                      }
                      return NewFeedItemView(
                        isShowComment: true,
                        item: _cubit.reviews[index],
                        disablNextProfile: true,
                        likePressed: () => _cubit.likePost(context, index),
                        sendComment: () => _cubit.sendComment(index),
                        nextToDetail: () => Navigator.of(context).pushNamed(
                          RouterName.detail_review,
                          arguments: _cubit.reviews[index],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildShowSavedBtn(BuildContext context) {
    return Container(
      height: 56,
      child: Column(
        children: [
          _buildOptionItemView(
            'Địa điểm đã lưu',
            SvgPicture.asset(
              ConstantIcons.ic_bookmark_outline,
            ),
            onPressed: () =>
                Navigator.of(context).pushNamed(RouterName.places_saved),
          ),
          // _buildOptionItemView(
          //   'Khuyến mãi đã lưu',
          //   Image.asset(
          //     ConstantIcons.ic_discount,
          //     height: 24,
          //     width: 24,
          //   ),
          // )
        ],
      ),
    );
  }

  Widget _buildFollowView(BuildContext context) {
    return BlocBuilder<AccountCubit, AccountState>(
      buildWhen: (previous, current) =>
          current is AccountGetProfileDoneState ||
          current is AccountUpdateFollowState,
      builder: (_, state) {
        return Container(
          height: 72,
          width: double.infinity,
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 24,
          ),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                flex: 7,
                child: InkWell(
                  onTap: () => _cubit.follow(context),
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: _cubit.user?.isFollowed == true
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _cubit.user?.isFollowed == true
                            ? SvgPicture.asset(
                                ConstantIcons.ic_user_check,
                              )
                            : SvgPicture.asset(
                                ConstantIcons.ic_plus,
                                color: Theme.of(context).primaryColor,
                              ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          _cubit.user?.isFollowed == true
                              ? 'Đang theo dõi'
                              : 'Theo dõi',
                          style: Theme.of(context).textTheme.headline4?.apply(
                                color: _cubit.user?.isFollowed == true
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                              ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 7,
              ),
              InkWell(
                onTap: () => _cubit.contact(context),
                child: Container(
                  width: 83,
                  decoration: BoxDecoration(
                    color: ColorConstant.neutral_gray_lightest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Liên hệ',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoUserView(BuildContext context) {
    return Container(
      height: 265,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<AccountCubit, AccountState>(
            buildWhen: (previous, current) =>
                current is AccountGetProfileDoneState,
            builder: (_, state) {
              return Column(
                children: [
                  _buildAvtView(context),
                  Text(
                    _cubit.user?.name ?? '',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Container(
                    // height: 24,
                    margin: const EdgeInsets.only(top: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ColorConstant.neutral_gray_lightest,
                    ),
                    child: Text(
                      _cubit.user?.createdAt != null
                          ? 'Ngày tham gia: ${AppUtils.convertDateToString(_cubit.user!.createdAt!)}'
                          : '',
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorConstant.neutral_black,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          _buildStatsView()
        ],
      ),
    );
  }

  Widget _buildStatsView() {
    return BlocBuilder<AccountCubit, AccountState>(
      buildWhen: (previous, current) => current is AccountGetStatsDoneState,
      builder: (_, state) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildSummaryInfoView(
                    'Bài viết',
                    '${_cubit.stats?.countReviews ?? 0}',
                  ),
                ),
                Expanded(
                  child: _buildSummaryInfoView(
                    'Người theo dõi',
                    '${_cubit.stats?.countFollowers ?? 0}',
                  ),
                ),
                Expanded(
                  child: _buildSummaryInfoView(
                    'Lượt thích',
                    '${_cubit.stats?.countLikes ?? 0}',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionItemView(
    String title,
    Widget icon, {
    Function()? onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: ColorConstant.neutral_gray_lightest,
            ),
          ),
        ),
        child: Row(
          children: [
            icon,
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            SvgPicture.asset(
              ConstantIcons.ic_chevron_right,
              color: ColorConstant.neutral_black,
            ),
          ],
        ),
      ),
    );
  }

  Container _buildSummaryInfoView(
    String title,
    String subtitle,
  ) {
    return Container(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: ColorConstant.neutral_gray,
            ),
          ),
          SizedBox(height: 7),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }

  Container _buildAvtView(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 35,
        bottom: 4,
      ),
      height: 86,
      width: 78,
      child: Stack(
        children: [
          ClipRRectImage(
            radius: 39,
            url: AppUtils.getUrlImage(
              _cubit.user?.avatar ?? '',
              height: 78,
              width: 78,
            ),
            width: 78,
            height: 78,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: VerifiedView(
              margin: const EdgeInsets.symmetric(horizontal: 4),
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
