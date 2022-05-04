import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonVoucher extends StatelessWidget {
  const SkeletonVoucher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonItem(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonAvatar(
            style: SkeletonAvatarStyle(
              height: 122,
              width: double.infinity,
            ),
          ),
          SkeletonParagraph(
            style: SkeletonParagraphStyle(
              lines: 2,
              spacing: 5,
              padding: const EdgeInsets.only(top: 8),
            ),
          )
        ],
      ),
    );
  }
}
