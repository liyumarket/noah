import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noahrealstate/app/config/color_constant.dart';
import 'package:noahrealstate/app/modules/home/views/bottom_sheet.dart';
import 'package:noahrealstate/app/routes/app_pages.dart';
import 'package:noahrealstate/app/widgets/drawer.dart';
import 'package:noahrealstate/app/widgets/property_card.dart';
import '../controllers/viewallproperties_controller.dart';

class ViewallpropertiesView extends GetView<ViewallpropertiesController> {
  const ViewallpropertiesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Colors.grey.shade100,
        title: Text(
          'Projects',
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        scrolledUnderElevation: 0.0,
        actions: [],
      ),
      drawer: controller.hasDrawer ? AppDrawer() : null,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: 18.w, right: 18.w, top: 4.h, bottom: 12.h),
                child: SearchBar(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  controller: controller.searchController,
                  leading: const Icon(Icons.search, color: Color(0xffB5B8BC)),
                  hintText: 'search property',
                  trailing: [
                    controller.isActiveProjects
                        ? SizedBox(
                            width: 130.w,
                            child: DropdownButtonFormField(
                                hint: Text(
                                  'Filter by status',
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                                items: controller.dropdownFilter
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? val) =>
                                    controller.selectedDropDown(val!)),
                          )
                        : IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return const FilterBottomSheet();
                                },
                              );
                            },
                            icon: Icon(
                              Icons.filter_alt,
                              color: ColorConstants.primaryColor,
                            ),
                          ),
                  ],
                  onSubmitted: (value) {
                    controller.filterProperties();
                  },
                ),
              ),
              Expanded(
                child: controller.properties.isEmpty
                    ? const Center(child: Text('No project found'))
                    : GetBuilder(
                        builder: (ViewallpropertiesController controller) {
                    
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.w),
                          child: CustomScrollView(
                            slivers: [
                              SliverGrid(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Number of items per row
                                  mainAxisSpacing: 10.h, // Space between rows
                                  crossAxisSpacing:
                                      16.w, // Space between columns
                                  childAspectRatio:
                                      0.8, // Aspect ratio of the items
                                ),
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () => Get.toNamed(
                                          Routes.PROPERTY_DETAIL,
                                          arguments:
                                              controller.properties[index]),
                                      child: Propertycard(
                                          property:
                                              controller.properties[index]),
                                    );
                                  },
                                  childCount: controller.properties.length ?? 0,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
