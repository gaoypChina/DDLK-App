import 'package:diadiemlongkhanh/config/env_config.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MiniMapView extends StatefulWidget {
  const MiniMapView({
    Key? key,
    this.height,
    this.width,
    this.lat,
    this.long,
  }) : super(key: key);
  final double? width;
  final double? height;
  final double? lat;
  final double? long;

  @override
  State<MiniMapView> createState() => _MiniMapViewState();
}

class _MiniMapViewState extends State<MiniMapView> {
  MapboxMapController? mapController;
  _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    mapController?.addSymbol(
      SymbolOptions(
        geometry: LatLng(widget.lat ?? 0, widget.long ?? 0),
        iconImage: ConstantIcons.ic_marker_full,
      ),
    );
  }

  _onStyleLoadedCallback() {
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text("Style loaded :)"),
    //   backgroundColor: Theme.of(context).primaryColor,
    //   duration: Duration(seconds: 1),
    // ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: MapboxMap(
        styleString: MapboxStyles.MAPBOX_STREETS,
        accessToken: Environment().config.mapAccessToken,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
            zoom: 14,
            target: LatLng(
              widget.lat ?? 0,
              widget.long ?? 0,
            )),
        onStyleLoadedCallback: _onStyleLoadedCallback,
      ),
    );
  }
}
