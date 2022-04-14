import 'package:flutter/material.dart';

import 'place_grid_item_view.dart';

class PlacesGridView extends StatelessWidget {
  final ScrollPhysics? physics;
  final double? topPadding;
  final double? bottomPadding;
  PlacesGridView({
    this.physics,
    this.topPadding,
    this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: physics,
      itemCount: 6,
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
        return PlaceGridItemView();
      },
    );
  }
}
