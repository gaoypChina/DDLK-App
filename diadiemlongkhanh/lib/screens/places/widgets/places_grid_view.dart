import 'package:diadiemlongkhanh/models/remote/place_response/place_response.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

import 'place_grid_item_view.dart';

class PlacesGridView extends StatelessWidget {
  final ScrollPhysics? physics;
  final double? topPadding;
  final double? bottomPadding;
  final List<PlaceModel> places;
  PlacesGridView({
    this.physics,
    this.topPadding,
    this.bottomPadding,
    this.places = const [],
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: physics,
      itemCount: places.isEmpty ? 4 : places.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: topPadding ?? 10,
        bottom: bottomPadding ?? 48,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 238,
      ),
      itemBuilder: (BuildContext context, int index) {
        return places.isEmpty
            ? Container(
                height: 238,
                child: SkeletonItem(
                  child: Column(
                    children: [
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          height: 148,
                          width: double.infinity,
                        ),
                      ),
                      SkeletonParagraph(
                        style: SkeletonParagraphStyle(
                          lines: 3,
                          spacing: 5,
                          padding: const EdgeInsets.only(top: 8),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : PlaceGridItemView(
                item: places[index],
              );
      },
    );
  }
}
