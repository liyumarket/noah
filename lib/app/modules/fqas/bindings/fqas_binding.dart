import 'package:get/get.dart';

import '../controllers/fqas_controller.dart';

class FqasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FqasController>(
      () => FqasController(),
    );
  }
}
