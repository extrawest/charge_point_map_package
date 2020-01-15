library charge_point_map_package;

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChargePointMapPackage {
  static BitmapDescriptor imageBitmap;

  static Future<void> initialize(BuildContext context) async {
    imageBitmap = await _getAssetsBitmapImage(context);
  }

  static Future<BitmapDescriptor> _getAssetsBitmapImage(BuildContext context)  async{
    final Completer<BitmapDescriptor> bitmapIcon = Completer<BitmapDescriptor>();
    final ImageConfiguration config = createLocalImageConfiguration(context);

    AssetImage(_getImagePathByStatus(), package: "charge_point_map_package")
        .resolve(config)
        .addListener(ImageStreamListener((ImageInfo image, bool _) async {
      final ByteData bytes = await image.image.toByteData(format: ImageByteFormat.png);
      final BitmapDescriptor bitmap = BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
      bitmapIcon.complete(bitmap);
    }));
    return await bitmapIcon.future;
  }

  static String _getImagePathByStatus() {
    return "assets/pin_aaa.png";
  }
}


class ChargePointMarker extends Marker {
  ChargePointMarker({
    @required MarkerId markerId,
    double alpha = 1.0,
    bool consumeTapEvents = false,
    bool draggable = false,
    bool flat = false,
    LatLng position,
    double rotation = 0.0,
    bool visible = true,
    double zIndex = 0.0,
    VoidCallback onTap,
    ValueChanged<LatLng> onDragEnd,
  }) : super(
      markerId: markerId,
      alpha: alpha,
      consumeTapEvents: consumeTapEvents,
      draggable: draggable,
      flat: flat,
      icon: ChargePointMapPackage.imageBitmap ?? BitmapDescriptor.defaultMarker,
      position: position,
      rotation: rotation,
      visible: visible,
      zIndex: zIndex,
      onTap: onTap,
      onDragEnd: onDragEnd);
}


