import 'package:get/get.dart';

import '../controllers/viewallproperties_controller.dart';

class ViewallpropertiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewallpropertiesController>(
      () => ViewallpropertiesController(),
    );
  }
}
