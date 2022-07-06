import 'package:diadiemlongkhanh/models/remote/new_feed/new_feed_response.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/services/storage/storage_service.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

part 'new_feed_state.dart';

class NewFeedCubit extends Cubit<NewFeedState> {
  NewFeedCubit() : super(NewFeedInitialState());
  int page = 1;
  List<NewFeedModel> newfeeds = [];
  bool isLast = false;
  bool isLoading = false;

  Future<void> onRefresh() async {
    page = 1;
    getNewFeeds();
  }

  getNewFeeds() async {
    try {
      final res = await injector.get<ApiClient>().getExplores(
            page: page,
          );
      print(res);
      isLoading = false;
      if (res != null) {
        final _reviews = res.result;
        _reviews.forEach((e) {
          e.controller = TextEditingController();
        });
        if (page == 1) {
          newfeeds = _reviews;
        } else {
          newfeeds.addAll(_reviews);
        }
        isLast = res.info!.total == newfeeds.length;
        emit(NewFeedGetDoneState());
      }
    } catch (error) {
      print(error);
    }
  }

  shareReview(NewFeedModel review) async {
    final url = AppUtils.getReviewUrl(review.slug ?? '');
    Share.share(url);
  }

  loadMoreReviews() async {
    if (isLast || isLoading) {
      return;
    }
    emit(NewFeedLoadingState());
    page += 1;
    isLoading = true;
    getNewFeeds();
  }

  sendComment(index) async {
    final data = {
      'review': newfeeds[index].id,
      'content': newfeeds[index].controller?.text ?? '',
    };
    final res = await injector.get<ApiClient>().commentReview(data);
    if (res != null) {
      newfeeds[index].commentCount += 1;
      newfeeds[index].controller?.text = '';
      emit(NewFeedGetDoneState());
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
    if (!newfeeds[index].isLiked) {
      final res = await injector.get<ApiClient>().likeReview(
            newfeeds[index].id ?? '',
          );
      if (res != null && res.success == true) {
        newfeeds[index].isLiked = true;
        newfeeds[index].likeCount += 1;
        emit(NewFeedGetDoneState());
      }
    } else {
      final res = await injector.get<ApiClient>().unLikeReview(
            newfeeds[index].id ?? '',
          );
      if (res != null && res.success == true) {
        newfeeds[index].isLiked = false;
        newfeeds[index].likeCount -= 1;
        emit(NewFeedGetDoneState());
      }
    }
  }
}
