import 'package:diadiemlongkhanh/models/remote/new_feed/new_feed_response.dart';
import 'package:diadiemlongkhanh/models/remote/stats/stats_response.dart';
import 'package:diadiemlongkhanh/models/remote/user/user_response.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/screens/profile/widgets/info_contact_dialog.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/services/storage/storage_service.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/utils/global_value.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit({
    this.userId,
  }) : super(AccountInitialState());
  final String? userId;
  List<NewFeedModel> reviews = [];
  int page = 1;
  bool isLast = false;
  bool isLoading = false;
  StatsModel? stats;
  UserModel? user;
  getReviewsOfUser() async {
    final res = await injector.get<ApiClient>().getReviewsOfUser(
          userId ?? GlobalValue.id!,
          page: page,
        );
    isLoading = false;
    if (res != null) {
      final _reviews = res.result;
      _reviews.forEach((e) {
        e.controller = TextEditingController();
      });
      if (page == 1) {
        reviews = _reviews;
      } else {
        reviews.addAll(_reviews);
      }
      if (res.info!.total == reviews.length) {
        isLast = true;
      } else {
        isLast = false;
      }
      emit(AccountGetReviewsDoneState());
    }
  }

  getUserStats() async {
    final res = await injector.get<ApiClient>().getUserStats(
          userId ?? GlobalValue.id!,
        );
    if (res != null) {
      stats = res;
      emit(AccountGetStatsDoneState());
    }
  }

  loadMoreReviews() async {
    if (isLast || isLoading) {
      return;
    }
    emit(AccountLoadingState());
    page += 1;
    isLoading = true;
    getReviewsOfUser();
  }

  getInfoUser() async {
    try {
      final res = await injector.get<ApiClient>().getProfileWithId(
            id: userId ?? GlobalValue.id!,
          );
      if (res != null) {
        user = res;
        emit(AccountGetProfileDoneState());
      }
    } catch (error) {
      print(error);
    }
  }

  follow(BuildContext context) async {
    if (injector.get<StorageService>().getToken() == null) {
      Navigator.of(context).pushNamed(
        RouterName.option_login,
        arguments: true,
      );
      return;
    }
    if (user?.isFollowed == false) {
      _follow();
    } else {
      _unfollow();
    }
  }

  _follow() async {
    final res = await injector.get<ApiClient>().follow(userId ?? '');
    if (res != null && res.success == true) {
      user?.isFollowed = true;
      emit(AccountUpdateFollowState());
    }
  }

  _unfollow() async {
    final res = await injector.get<ApiClient>().unfollow(userId ?? '');
    if (res != null && res.success == true) {
      user?.isFollowed = false;
      emit(AccountUpdateFollowState());
    }
  }

  contact(BuildContext context) {
    if (user == null) {
      return;
    }
    AppUtils.showBottomDialog(
      context,
      InfoContactDialog(
        user: user!,
      ),
    );
  }

  sendComment(index) async {
    final data = {
      'review': reviews[index].id,
      'content': reviews[index].controller?.text ?? '',
    };
    final res = await injector.get<ApiClient>().commentReview(data);
    if (res != null) {
      reviews[index].commentCount += 1;
      reviews[index].controller?.text = '';
      emit(AccountGetReviewsDoneState());
    }
  }

  likePost(
    BuildContext context,
    int index,
  ) async {
    final token = await injector.get<StorageService>().getToken();
    if (token == null) {
      Navigator.of(context).pushNamed(
        RouterName.option_login,
        arguments: true,
      );
      return;
    }
    if (!reviews[index].isLiked) {
      final res = await injector.get<ApiClient>().likeReview(
            reviews[index].id ?? '',
          );
      if (res != null && res.success == true) {
        reviews[index].isLiked = true;
        reviews[index].likeCount += 1;
        emit(AccountGetReviewsDoneState());
      }
    } else {
      final res = await injector.get<ApiClient>().unLikeReview(
            reviews[index].id ?? '',
          );
      if (res != null && res.success == true) {
        reviews[index].isLiked = false;
        reviews[index].likeCount -= 1;
        emit(AccountGetReviewsDoneState());
      }
    }
  }
}
