import 'package:flutter/material.dart';

import 'shimmer_image.dart';
import 'shimmer_paragraph.dart';

class ShimmerNewFeed extends StatelessWidget {
  const ShimmerNewFeed(
    this.context,
  );

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Row(
            children: [
              ShimmerImage(
                shape: BoxShape.circle,
                width: 50,
                height: 50,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: ShimmerParagraph(),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ShimmerParagraph(),
          SizedBox(
            height: 10,
          ),
          ShimmerImage(
            width: double.infinity,
            height: 218,
          ),
        ],
      ),
    );
  }
}
