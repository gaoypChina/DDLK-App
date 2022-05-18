import 'package:diadiemlongkhanh/models/remote/comment/comment_response.dart';
import 'package:diadiemlongkhanh/models/remote/new_feed/new_feed_response.dart';
import 'package:diadiemlongkhanh/screens/new_feeds/widgets/new_feed_item_view.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
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
  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Bài của ${widget.item?.author?.name ?? ''}',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NewFeedItemView(
              item: widget.item,
              margin: const EdgeInsets.all(0),
              decoration: BoxDecoration(),
              comments: comments,
            )
          ],
        ),
      ),
    );
  }
}
