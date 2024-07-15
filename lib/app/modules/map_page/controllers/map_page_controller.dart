import 'package:get/get.dart';

class MapPageController extends GetxController {
  //TODO: Implement MapPageController

  final count = 0.obs;
  String link = Get.arguments;
  RxString latitude = '38.84759887945769'.obs;
  RxString longitude = '9.020728667938215'.obs;

  void extractLatLong(String url) {
    final RegExp latRegex = RegExp(r'!3d([0-9.]+)!2d([0-9.]+)');
    final match = latRegex.firstMatch(url);
    print(match);
    if (match != null) {
      latitude.value = match.group(1)!;
      longitude.value = match.group(2)!;
    }
  }

  @override
  void onInit() {
    extractLatLong(link);
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
