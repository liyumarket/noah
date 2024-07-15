import 'package:get/get.dart';
import 'package:noahrealstate/app/modules/activeproperties/controllers/viewallproperties_controller.dart';


class ActivepropertiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivepropertiesController>(
      () => ActivepropertiesController(),
    );
  }
}
