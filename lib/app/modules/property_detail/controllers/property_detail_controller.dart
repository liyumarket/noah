import 'dart:convert';

import 'package:get/get.dart';
import 'package:noahrealstate/app/data/model/data_model.dart';

class PropertyDetailController extends GetxController {
  //TODO: Implement PropertyDetailController

  final count = 0.obs;
  Property property = Get.arguments;
  RxBool apartmentSelected = true.obs;
  String latitude = '38.7793489112354';
  String longitude = '9.005572616145294';
  void extractLatLong(String url) {
    final RegExp latLongRegex = RegExp(r'!2d([\-0-9.]+)!3d([\-0-9.]+)');
    final match = latLongRegex.firstMatch(url);



    if (match != null) {
      latitude = match.group(2)!;
      longitude = match.group(1)!;
    
    } else {
 
    }
  }

  String formatStringForMultipleLines(String input) {
    try {
      // Try to decode the input as JSON
      List<dynamic> decoded = jsonDecode(input);

      if (decoded is List) {
        // Join the list items with newline characters
        return decoded.map((item) => item.toString()).join('\n');
      }
    } catch (e) {
      // If decoding fails, it's likely a single string, so return it as is
    }

    return input;
  }

  @override
  void onInit() {
    extractLatLong(property.mapLink ?? '');
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
