import 'package:diadiemlongkhanh/models/remote/comment/comment_response.dart';
import 'package:diadiemlongkhanh/models/remote/new_feed/new_feed_response.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/screens/new_feeds/widgets/new_feed_item_view.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/services/storage/storage_service.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:flutter/material.dart';

class DetailReviewScreen extends StatefulWidget {
  final NewFeedModel? item;
  const DetailReviewScreen({
    Key? key,
    this.item,
  }) : super(key: key);

  @override
  State<DetailReviewScreen> createState() => _DetailReviewScreenState();
}

class _DetailReviewScreenState extends State<DetailReviewScreen> {
  List<CommentModel> comments = [];
  late NewFeedModel item;
  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      item = widget.item!;
      item.controller = TextEditingController();
    }
    _getCommentOfReview();
  }

  _getCommentOfReview() async {
    final res = await injector
        .get<ApiClient>()
        .getCommentyOfReview(widget.item?.id ?? '');
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
      'review': item.id,
      'content': item.controller?.text ?? '',
    };
    final res = await injector.get<ApiClient>().commentReview(data);
    if (res != null) {
      setState(() {
        item.commentCount += 1;
        item.controller?.text = '';
      });
      _getCommentOfReview();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Bài của ${item.author?.name ?? ''}',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              NewFeedItemView(
                item: item,
                margin: const EdgeInsets.all(0),
                decoration: BoxDecoration(),
                comments: comments,
                isShowComment:
                    injector.get<StorageService>().getToken() != null,
                sendComment: sendComment,
                likeComment: (index) => likeComment(index),
              )
            ],
          ),
        ),
      ),
    );
  }
}
