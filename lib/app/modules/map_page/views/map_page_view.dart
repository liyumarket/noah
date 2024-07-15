import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../controllers/map_page_controller.dart';

class MapPageView extends GetView<MapPageController> {
  MapPageView({Key? key}) : super(key: key);
  MapController controler = MapController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        mapController: controler,
        options: MapOptions(
          initialCenter: LatLng(double.parse(controller.latitude.value),
                      double.parse(controller.longitude.value)),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          Obx(
            () => MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(double.parse(controller.latitude.value),
                      double.parse(controller.longitude.value)),
                  width: 80.h,
                  height: 80.h,
                  child: const Icon(
                    Icons.location_pin,
                    size: 50,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
