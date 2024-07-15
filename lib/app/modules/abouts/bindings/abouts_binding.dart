import 'package:get/get.dart';

import '../controllers/abouts_controller.dart';

class AboutsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutsController>(
      () => AboutsController(),
    );
  }
}
