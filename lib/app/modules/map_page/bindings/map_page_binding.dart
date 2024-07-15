import 'package:get/get.dart';

import '../controllers/map_page_controller.dart';

class MapPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapPageController>(
      () => MapPageController(),
    );
  }
}
