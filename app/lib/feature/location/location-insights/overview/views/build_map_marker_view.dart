import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

Marker buildMapMarkerView(
  final double latitude,
  final double longitude,
  final String assetIcon,
  final String serialNumber,
) {
  return Marker(
    point: LatLng(latitude, longitude),
    width: 40,
    height: 40,
    child: Tooltip(
      triggerMode: TooltipTriggerMode.tap,
      preferBelow: false,
      message: serialNumber,
      child: Image.asset(
        assetIcon,
        width: AppStyle.iconSize40,
        height: AppStyle.iconSize40,
      ),
    ),
  );
}
