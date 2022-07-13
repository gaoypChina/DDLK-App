import 'package:diadiemlongkhanh/models/local/report_type_model.dart';
import 'package:diadiemlongkhanh/models/remote/comment/comment_response.dart';
import 'package:diadiemlongkhanh/models/remote/new_feed/new_feed_response.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/screens/new_feeds/widgets/new_feed_item_view.dart';
import 'package:diadiemlongkhanh/screens/places/widgets/place_action_dialog.dart';
import 'package:diadiemlongkhanh/screens/skeleton_view/shimmer_newfeed.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/services/storage/storage_service.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class DetailReviewScreen extends StatefulWidget {
  final NewFeedModel? item;
  final String? id;
  const DetailReviewScreen({
    Key? key,
    this.item,
    this.id,
  }) : super(key: key);

  @override
  State<DetailReviewScreen> createState() => _DetailReviewScreenState();
}

class _DetailReviewScreenState extends State<DetailReviewScreen> {
  List<CommentModel> comments = [];
  NewFeedModel? item;
  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      item = widget.item!;
      item?.controller = TextEditingController();
      _getCommentOfReview(widget.item?.id ?? '');
    } else if (widget.id != null) {
      _getDetail();
    }
  }

  _getDetail() async {
    final res = await injector.get<ApiClient>().getDetailReview(widget.id!);
    if (res != null) {
      item = res;
      item?.controller = TextEditingController();
      _getCommentOfReview(widget.id!);
    }
  }

  _getCommentOfReview(String id) async {
    final res = await injector.get<ApiClient>().getCommentyOfReview(id);
    if (res != null) {
      setState(() {
        comments = res;
      });
    }
  }

  likeComment(int index) async {
    if (injector.get<StorageService>().getToken() == null) {
      Navigator.of(context).pushNamed(
        RouterName.option_login,
        arguments: true,
      );
      return;
    }
    if (comments[index].isLiked) {
      unlikeComment(index);
      return;
    }
    final res = await injector
        .get<ApiClient>()
        .likeCommentReview(comments[index].id ?? '');
    if (res != null && res.success == true) {
      setState(() {
        comments[index].isLiked = true;
        comments[index].likeCount += 1;
      });
    }
  }

  unlikeComment(index) async {
    final res = await injector
        .get<ApiClient>()
        .unlikeCommentReview(comments[index].id ?? '');
    if (res != null && res.success == true) {
      setState(() {
        comments[index].isLiked = false;
        comments[index].likeCount -= 1;
      });
    }
  }

  sendComment() async {
    final data = {
      'review': item?.id,
      'content': item?.controller?.text ?? '',
    };
    final res = await injector.get<ApiClient>().commentReview(data);
    if (res != null) {
      setState(() {
        item?.commentCount += 1;
        item?.controller?.text = '';
      });
      _getCommentOfReview(widget.item?.id ?? '');
    }
  }

  _likePost() async {
    final token = await injector.get<StorageService>().getToken();
    if (token == null) {
      Navigator.of(context).pushNamed(
        RouterName.option_login,
        arguments: true,
      );
      return;
    }
    if (!item!.isLiked) {
      final res = await injector.get<ApiClient>().likeReview(item?.id ?? '');
      if (res != null && res.success == true) {
        setState(() {
          item!.isLiked = true;
          item!.likeCount += 1;
        });
      }
    } else {
      final res = await injector.get<ApiClient>().unLikeReview(item?.id ?? '');
      if (res != null && res.success == true) {
        setState(() {
          item!.isLiked = false;
          item!.likeCount -= 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: MyAppBar(
          title: 'Bài của ${item?.author?.name ?? ''}',
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                item != null
                    ? NewFeedItemView(
                        item: item,
                        margin: const EdgeInsets.all(0),
                        decoration: BoxDecoration(),
                        comments: comments,
                        isShowComment:
                            injector.get<StorageService>().getToken() != null,
                        sendComment: sendComment,
                        likeComment: (index) => likeComment(index),
                        likePressed: _likePost,
                        moreSelect: () => AppUtils.showBottomDialog(
                          context,
                          PlaceActionDiaglog(
                            type: ReportType.review,
                            docId: item?.id,
                            showShare: true,
                            onShare: shareReview,
                          ),
                        ),
                      )
                    : ShimmerNewFeed(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  shareReview() async {
    final url = AppUtils.getReviewUrl(item?.slug ?? '');
    Share.share(url);
  }
}
