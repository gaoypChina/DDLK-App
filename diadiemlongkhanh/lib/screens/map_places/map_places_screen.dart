import 'dart:typed_data';

import 'package:diadiemlongkhanh/config/env_config.dart';
import 'package:diadiemlongkhanh/models/remote/place_response/place_response.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/screens/places/bloc/list_places_cubit.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/utils/global_value.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:diadiemlongkhanh/widgets/my_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:mapbox_gl/mapbox_gl.dart';

class MapPlacesSreen extends StatefulWidget {
  MapPlacesSreen({
    Key? key,
    this.places,
  }) : super(key: key);
  final List<PlaceModel>? places;
  @override
  State<MapPlacesSreen> createState() => _MapPlacesSreenState();
}

class _MapPlacesSreenState extends State<MapPlacesSreen> {
  MapboxMapController? mapController;
  List<PlaceModel> places = [];

  @override
  void initState() {
    super.initState();
    if (widget.places != null) {
      places = widget.places!;
    }
  }

  _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    for (var item in places) {
      mapController?.addSymbol(
        SymbolOptions(
          geometry: LatLng(
            item.address?.geo?.lat ?? 0,
            item.address?.geo?.long ?? 0,
          ),
          iconImage: ConstantIcons.ic_marker_full,
        ),
      );
    }
  }

  _onStyleLoadedCallback() {
    print('style loaded');
  }

  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController!.addImage(name, list);
  }

  // /// Adds a network image to the currently displayed style
  // Future<void> addImageFromUrl(String name, Uri uri) async {
  //   var response = await http.get(uri);
  //   return controller!.addImage(name, response.bodyBytes);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Danh sách địa điểm'),
      body: Stack(children: [
        MapboxMap(
          styleString: MapboxStyles.MAPBOX_STREETS,
          accessToken: Environment().config.mapAccessToken,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            zoom: 20,
            target: LatLng(places.first.address?.geo?.lat ?? 0,
                places.first.address?.geo?.long ?? 0),
          ),
          onStyleLoadedCallback: _onStyleLoadedCallback,
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 30,
          child: _buildListPlaceView(),
        )
      ]),
    );
  }

  Container _buildListPlaceView() {
    return Container(
      height: 112,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: places.length,
        padding: const EdgeInsets.only(left: 16),
        itemBuilder: (_, index) {
          final item = places[index];
          return InkWell(
            onTap: () {
              LatLng newCenter = LatLng(
                  item.address?.geo?.lat ?? 0, item.address?.geo?.long ?? 0);
              CameraUpdate cameraUpdate =
                  CameraUpdate.newLatLngZoom(newCenter, 20);
              mapController?.moveCamera(cameraUpdate);
            },
            child: Container(
              height: 112,
              width: 268,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  ClipRRectImage(
                    width: 96,
                    radius: 8,
                    url: AppUtils.getUrlImage(
                      item.avatar?.path ?? '',
                      width: 96,
                      height: 96,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppUtils.getOpeningTitle(
                                      item.openingStatus ?? ''),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppUtils.getOpeningColor(
                                        item.openingStatus ?? ''),
                                  ),
                                ),
                                Text(
                                  AppUtils.getDistance(item.distance ?? 0) == 0
                                      ? ''
                                      : 'Cách ${AppUtils.getDistance(item.distance ?? 0)}km',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: ColorConstant.neutral_gray,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              item.name ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  AppUtils.roundedRating(
                                          item.rate?.summary ?? 0)
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                MyRatingBar(
                                  rating: item.rate?.summary ?? 0,
                                  onRatingUpdate: (rate, isEmpty) {},
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              ConstantIcons.ic_marker_grey,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                item.address?.specific ?? '',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstant.neutral_gray_lighter,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
