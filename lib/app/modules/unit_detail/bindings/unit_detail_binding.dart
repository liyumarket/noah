import 'package:get/get.dart';

import '../controllers/unit_detail_controller.dart';

class UnitDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UnitDetailController>(
      () => UnitDetailController(),
    );
  }
}
