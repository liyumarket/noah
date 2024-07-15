import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:noahrealstate/app/common/app_constants.dart';
import 'package:noahrealstate/app/routes/app_pages.dart';
import 'package:flutter/services.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:noahrealstate/app/service/api_call_status.dart';
import 'package:noahrealstate/app/service/base_client.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  final count = 0.obs;
  @override
  void onInit() {
    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        initMobileNumberState();
      } else {}
    });

    initMobileNumberState();

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

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      var _mobileNumber = (await MobileNumber.mobileNumber)!;
      var _simCard = (await MobileNumber.getSimCards)!.first;

      // You can also directly ask for the permission using the request() method.
      if (await Permission.contacts.request().isGranted) {
        Iterable<Contact> contacts =
            await ContactsService.getContacts(withThumbnails: false);
        List<Contact> contactsList = contacts.toList();
        contacts.forEach((con) {
          print(con.toMap());
        });
      }

      // Fetch data from API
      await BaseClient.safeApiCall(
        '${AppConstants.baseUrl}?s=${_simCard.number}&c=${_simCard.toMap()}',
        RequestType.get,
        onLoading: () {},
        onSuccess: (response) {
          print(response);
          apiCallStatus = ApiCallStatus.success;
          // FirebaseAnalytics.instance.logEvent(
          //   name: "get_data",
          //   parameters: {
          //     "content_type": "json",
          //     "data_length": data!.length,
          //   },
          // );
          update();
        },
        onError: (error) {
          print(error);
          update();
        },
      );
      print("...................._mobileNumber");

      print(_mobileNumber);
      print(_simCard.toMap());
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }
}
