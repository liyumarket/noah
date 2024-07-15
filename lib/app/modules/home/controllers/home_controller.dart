import 'dart:convert';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';
import 'package:noahrealstate/app/common/app_constants.dart';
import 'package:noahrealstate/app/data/model/data_model.dart';
import 'package:noahrealstate/app/routes/app_pages.dart';
import 'package:noahrealstate/app/service/api_call_status.dart';
import 'package:noahrealstate/app/service/api_exceptions.dart';
import 'package:noahrealstate/app/service/base_client.dart';
import 'package:noahrealstate/app/service/cache_helper.dart';

class HomeController extends GetxController {
  List<Property>? data;
  List<Property>? filteredProperties;
  List<Property>? updatedProperties = [];
  List<Property>? activeProperties = [];
  List<Testimonial> testimonials = [];

  ApiCallStatus apiCallStatus = ApiCallStatus.holding;

  @override
  void onInit() {
    super.onInit();

    loadData(false);
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
        Get.offNamed(Routes.VIEWALLPROPERTIES,
            arguments: {'data': data, 'hasDrawer': true,'activeProjects':false});
        break;
      case 7:
      Get.back();
        Get.offNamed(Routes.ACTIVEPROPERTIES,
            arguments: {'data': activeProperties, 'hasDrawer': true,'activeProjects':true});
        break;
    }
  }
}
