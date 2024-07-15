import 'package:get/get.dart';

import '../controllers/update_detail_controller.dart';

class UpdateDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateDetailController>(
      () => UpdateDetailController(),
    );
  }
}
