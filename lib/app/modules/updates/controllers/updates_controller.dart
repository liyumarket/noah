import 'package:get/get.dart';
import 'package:noahrealstate/app/data/model/data_model.dart';
import 'package:noahrealstate/app/modules/home/controllers/home_controller.dart';

class UpdatesController extends GetxController {
  HomeController homeController = Get.find();
  var data = <Property>[].obs;  // Reactive list

  @override
  void onInit() {
    super.onInit();
    data.value = homeController.data ?? [];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
