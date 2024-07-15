import 'package:get/get.dart';

import '../controllers/property_detail_controller.dart';

class PropertyDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PropertyDetailController>(
      () => PropertyDetailController(),
    );
  }
}
