import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noahrealstate/app/config/color_constant.dart';
import 'package:noahrealstate/app/config/styles.dart';
import 'package:noahrealstate/app/data/model/data_model.dart';
import 'package:noahrealstate/app/modules/home/controllers/home_controller.dart';
import 'package:noahrealstate/app/modules/viewallproperties/controllers/viewallproperties_controller.dart';
import 'package:noahrealstate/app/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  List<String> selectedProjectTypes = [];
  List<String> selectedStatuses = [];
  List<String> selectedLocations = [];
  List<String> projectTypes = [
    "Residential Apartment",
    "Commercial",
    "Mixed Use"
  ];
  List<String> statuses = [
    "Now Available",
    "Coming Soon",
    "Newly Launched",
    "Delivered"
  ];
  List<String> locations = ["Location A", "Location B", "Location C"];
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      padding: EdgeInsets.all(16.w),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Filter Properties',
              style: GoogleFonts.montserrat(
                  fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            _buildOptionContainers(
              label: 'Project Type',
              selectedValues: selectedProjectTypes,
              items: projectTypes,
              onTap: (value) {
                setState(() {
                  if (selectedProjectTypes.contains(value)) {
                    selectedProjectTypes.remove(value);
                  } else {
                    selectedProjectTypes.add(value);
                  }
                });
              },
            ),
            _buildOptionContainers(
              label: 'Status',
              selectedValues: selectedStatuses,
              items: statuses,
              onTap: (value) {
                setState(() {
                  if (selectedStatuses.contains(value)) {
                    selectedStatuses.remove(value);
                  } else {
                    selectedStatuses.add(value);
                  }
                });
              },
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 40.h,
                    width: 100.w,
                    color: ColorConstants.darkButton,
                    child: Center(
                      child: Text('Cancel',
                          style: GoogleFonts.montserrat(
                              fontSize: 14.sp, color: Colors.white)),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    List<Property> properties =
                        _filterProperties(homeController.data ?? []);
                    if (Get.currentRoute == Routes.VIEWALLPROPERTIES) {
                      ViewallpropertiesController allController = Get.find();
                      allController.setProperties(properties);
                     
                    } else {
                      Get.toNamed(Routes.VIEWALLPROPERTIES, arguments: {
                        'data': properties,
                        'hasDrawer': true,
                        'activeProjects': false
                      });
                    }
                  },
                  child: Container(
                    height: 40.h,
                    width: 100.w,
                    color: ColorConstants.primaryColor,
                    child: Center(
                      child: Text(
                        'Apply',
                        style: AppStyles.drawerTextStyle.copyWith(
                            color: ColorConstants.darkButton, fontSize: 14.sp),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Property> _filterProperties(List<Property> properties) {
    return properties.where((property) {
      final matchesProjectType = selectedProjectTypes.isEmpty ||
          selectedProjectTypes.contains(property.projectType);
      final matchesStatus = selectedStatuses.isEmpty ||
          selectedStatuses.contains(property.status);
      return matchesProjectType && matchesStatus;
    }).toList();
  }

  Widget _buildOptionContainers({
    required String label,
    required List<String> selectedValues,
    required List<String> items,
    required ValueChanged<String> onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.montserrat(fontSize: 16.sp)),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: items.map((item) {
            final isSelected = selectedValues.contains(item);
            return GestureDetector(
              onTap: () => onTap(item),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color:
                        isSelected ? ColorConstants.primaryColor : Colors.grey,
                    width: isSelected ? 2.0.w : 1.0.w,
                  ),
                  // borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  item,
                  style: GoogleFonts.montserrat(
                    fontSize: 14.sp,
                    color:
                        isSelected ? ColorConstants.primaryColor : Colors.black,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
