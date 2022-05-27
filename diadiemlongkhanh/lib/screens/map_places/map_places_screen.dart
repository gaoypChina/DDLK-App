import 'dart:typed_data';

import 'package:diadiemlongkhanh/config/env_config.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/utils/global_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';

class MapPlacesSreen extends StatefulWidget {
  const MapPlacesSreen({Key? key}) : super(key: key);

  @override
  State<MapPlacesSreen> createState() => _MapPlacesSreenState();
}

class _MapPlacesSreenState extends State<MapPlacesSreen> {
  // MapboxMapController? mapController;

  // _onMapCreated(MapboxMapController controller) {
  //   mapController = controller;
  // }

  _onStyleLoadedCallback() {
    // addImageFromAsset("assetImage", "assets/images/sydney.png");
    // addImageFromUrl(
    //     "networkImage", Uri.parse("https://via.placeholder.com/50"));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Style loaded :)"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 1),
    ));
  }

  // Future<void> addImageFromAsset(String name, String assetName) async {
  //   final ByteData bytes = await rootBundle.load(assetName);
  //   final Uint8List list = bytes.buffer.asUint8List();
  //   return mapController!.addImage(name, list);
  // }

  // /// Adds a network image to the currently displayed style
  // Future<void> addImageFromUrl(String name, Uri uri) async {
  //   var response = await http.get(uri);
  //   return controller!.addImage(name, response.bodyBytes);
  // }

  @override
  Widget build(BuildContext context) {
    // mapController?.addSymbol(
    //   SymbolOptions(
    //     geometry: LatLng(GlobalValue.lat ?? 0, GlobalValue.long ?? 0),
    //     iconImage: 'assets/images/sydney.png',
    //   ),
    // );
    return Scaffold(
      body: Container(),
      // MapboxMap(
      //   styleString: MapboxStyles.MAPBOX_STREETS,
      //   accessToken: Environment().config.mapAccessToken,
      //   onMapCreated: _onMapCreated,
      //   initialCameraPosition: CameraPosition(
      //       zoom: 20,
      //       target: LatLng(GlobalValue.lat ?? 0, GlobalValue.long ?? 0)),
      //   onStyleLoadedCallback: _onStyleLoadedCallback,
      // ),
    );
  }
}
