
import 'package:get/get.dart';
import 'package:noahrealstate/app/routes/app_pages.dart';
import 'package:noahrealstate/app/service/api_call_status.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  final count = 0.obs;
  @override
  void onInit() {
   

    super.onInit();
  }

  ApiCallStatus apiCallStatus = ApiCallStatus.holding;

  @override
  Future<void> onReady() async {
    await Future.delayed(const Duration(seconds: 5), () {
      Get.toNamed(Routes.HOME);
    });
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
