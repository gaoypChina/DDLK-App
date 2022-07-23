import 'package:diadiemlongkhanh/models/remote/place_response/place_response.dart';
import 'package:diadiemlongkhanh/screens/skeleton_view/shimmer_image.dart';
import 'package:diadiemlongkhanh/screens/skeleton_view/shimmer_paragraph.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletons/skeletons.dart';

import 'place_grid_item_view.dart';

class PlacesGridView extends StatelessWidget {
  final ScrollPhysics? physics;
  final double? topPadding;
  final double? bottomPadding;
  final List<PlaceModel> places;
  final Function(PlaceModel)? onSelect;
  final ScrollController? controller;

  PlacesGridView({
    this.physics,
    this.topPadding,
    this.bottomPadding,
    this.places = const [],
    this.onSelect,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: physics,
      itemCount: places.isEmpty ? 6 : places.length,
      shrinkWrap: true,
      controller: controller,
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
        final item = places.isEmpty ? null : places[index];
        return PlaceGridItemView(
          item: item,
          onSelect: () {
            if (item == null) return;
            if (onSelect != null) {
              onSelect!(places[index]);
            }
          },
        );
      },
    );
  }
}
