import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:noahrealstate/app/data/model/data_model.dart';
import 'package:noahrealstate/app/modules/home/controllers/home_controller.dart';

class ActivepropertiesController extends GetxController {
  List<Property> properties = <Property>[].obs;
  bool hasDrawer = Get.arguments['hasDrawer'];
  bool isActiveProjects = Get.arguments['activeProjects'] ?? false;
  HomeController controller = Get.find();
  TextEditingController searchController = TextEditingController();

  List<String> dropdownFilter = [
    'Now Available',
    'Newly Launched',
    'Delivered'
  ];

  RxString selectedFilter = 'Now Available'.obs;

  selectedDropDown(String val) {
    selectedFilter.value = val;
    properties = controller.data!
        .where((element) => element.status!.contains(val))
        .toList();
    update();
    // print(properties.length);
  }

  setProperties(List<Property> props) {
    properties = props;
    update();
  }

  void filterProperties() {
    final query = searchController.text.toLowerCase();
    final filteredProperties = controller.data?.where((property) {
          return property.title!.toLowerCase().contains(query);
        }).toList() ??
        [];
    properties = filteredProperties;
    update();
    FirebaseAnalytics.instance.logEvent(
      name: "filter_products",
      parameters: {
        "content_type": "json",
        "data_length": filteredProperties.length,
      },
    );
  }

  @override
  void onInit() {
    properties = Get.arguments['data'];
    super.onInit();
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
