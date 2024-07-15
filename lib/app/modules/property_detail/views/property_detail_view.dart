import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:noahrealstate/app/config/color_constant.dart';
import 'package:noahrealstate/app/config/styles.dart';
import 'package:noahrealstate/app/data/model/data_model.dart';
import 'package:noahrealstate/app/modules/property_detail/views/appartment_card.dart';
import 'package:noahrealstate/app/modules/property_detail/views/testimonial_card.dart';
import 'package:noahrealstate/app/routes/app_pages.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/property_detail_controller.dart';

class PropertyDetailView extends GetView<PropertyDetailController> {
  PropertyDetailView({Key? key}) : super(key: key);

  String removeHtmlTags(String htmlString) {
    final regExp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(regExp, '');
  }

  MapController controler = MapController();
  @override
  Widget build(BuildContext context) {
    // Initialize screenutil
    ScreenUtil.init(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        toolbarHeight: 60.h,
        scrolledUnderElevation: 0.0,
        title: Text(
          controller.property.title ?? 'Noah Real State',
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
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
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFFAFAFB),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.gray,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12.w),
                          bottomRight: Radius.circular(12.w)),
                    ),
                    child: Stack(
                      children: [
                        controller.property.images!.isNotEmpty
                            ? ImageSlideshow(
                                width: double.infinity,
                                height: 300.h,
                                initialPage: 0,
                                indicatorColor: ColorConstants.primaryColor,
                                indicatorBackgroundColor: Colors.grey,
                                autoPlayInterval: 3000,
                                isLoop: true,
                                children: controller.property.images!
                                    .map(
                                      (image) => CachedNetworkImage(
                                        imageUrl: image,
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            width: double.infinity,
                                            height: 300.h,
                                            color: Colors
                                                .white, // Placeholder color
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                    .toList(),
                              )
                            : Container(
                                height: 300.h,
                              ),
                        Positioned(
                          top: 200.h,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            padding: EdgeInsets.all(8.w),
                            child: Text(
                              controller.formatStringForMultipleLines(
                                  controller.property.projectType ?? ""),
                              style: GoogleFonts.montserrat(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Text(
                      controller.property.title ?? 'Noha',
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF363C45),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.w),
                    child: Text(
                      controller.property.location ?? '',
                      style: GoogleFonts.montserrat(
                        color: Color(0xFFB0B4BE),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: LinearProgressIndicator(
                      value: double.parse(
                              controller.property.projectProgress ?? '0') /
                          100,
                      backgroundColor: Colors.grey[300],
                      color: ColorConstants.primaryColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Text(
                      'Progress ${controller.property.projectProgress ?? '0'}%',
                      style: GoogleFonts.montserrat(
                        color: Color(0xFFB0B4BE),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.w),
                    child: Text(
                      controller.property.status ?? '',
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF363C45),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Text(
                      'Status',
                      style: GoogleFonts.montserrat(
                        color: Color(0xFFB0B4BE),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    width: 321.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(6.w),
                      border: Border.all(width: 1.w, color: Color(0xFFE5E8EC)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x08000000),
                          blurRadius: 2.w,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.w),
                          child: Text(
                            'Description',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.montserrat(
                              color: Color(0xFF363C45),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.w),
                          child: Text(
                            removeHtmlTags(
                                controller.property.description ?? ''),
                            style: GoogleFonts.montserrat(
                              color: Color(0xFF363C45),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 321.w,
                    height: 300.h,
                    margin: EdgeInsets.only(top: 20.h),
                    decoration: BoxDecoration(
                      color: ColorConstants.darkButton,
                      shape: BoxShape.rectangle,
                    ),
                    child: FlutterMap(
                      mapController: controler,
                      options: MapOptions(
                        // initialZoom: 20,
                        initialCenter: LatLng(double.parse(controller.latitude),
                            double.parse(controller.longitude)),
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: LatLng(double.parse(controller.latitude),
                                  double.parse(controller.longitude)),
                              width: 80.h,
                              height: 80.h,
                              child: const Icon(
                                Icons.location_pin,
                                size: 50,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: 321.w,
                      margin: EdgeInsets.only(top: 20.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(6.w),
                        border:
                            Border.all(width: 1.w, color: Color(0xFFE5E8EC)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x08000000),
                            blurRadius: 2.w,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Text(
                                'Payment Plans',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.montserrat(
                                  color: Color(0xFF363C45),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            controller.property.paymentPlans!.isNotEmpty
                                ? Column(
                                    children: controller.property.paymentPlans!
                                        .map((plan) {
                                      return Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.w),
                                        child: ListTile(
                                          title: Text(
                                            plan.title ?? '',
                                            style: GoogleFonts.montserrat(),
                                          ),
                                          subtitle: Text(
                                            plan.description ?? '',
                                            style: GoogleFonts.montserrat(),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  )
                                : Text('---'),
                          ])),
                  Padding(
                    padding: EdgeInsets.only(top: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => controller.apartmentSelected.value =
                              !controller.apartmentSelected.value,
                          child: Obx(() => Container(
                                width: 159.w,
                                height: 40.h,
                                color: controller.apartmentSelected.value
                                    ? ColorConstants.primaryColor
                                    : Colors.grey.shade300,
                                child: Center(
                                  child: Text(
                                    'Testimonials',
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )),
                        ),
                        Container(
                          width: 2.w,
                          height: 40.h,
                          color: ColorConstants.darkButton,
                        ),
                        InkWell(
                          onTap: () => controller.apartmentSelected.value =
                              !controller.apartmentSelected.value,
                          child: Obx(() => Container(
                                width: 159.w,
                                height: 40.h,
                                color: !controller.apartmentSelected.value
                                    ? ColorConstants.primaryColor
                                    : Colors.grey.shade300,
                                child: Center(
                                  child: Text(
                                    'Units',
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: controller.apartmentSelected.value
                          ? TestimonialListView(
                              testimonials:
                                  controller.property.testimonials ?? [],
                            )
                          : HorizontalUnitListView(
                              units: controller.property.units ?? [],
                            ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalUnitListView extends StatelessWidget {
  HorizontalUnitListView({Key? key, required this.units});
  final List<Unit> units;

  @override
  Widget build(BuildContext context) {
    print(units);

    return units.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: units.map((unit) {
              return Padding(
                padding: EdgeInsets.all(8.w), // Use ScreenUtil for padding
                child: InkWell(
                  onTap: () => Get.toNamed(Routes.UNIT_DETAIL, arguments: unit),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      // Use ScreenUtil for radius
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: 317.w, // Use ScreenUtil for width
                          height: 200.h, // Use ScreenUtil for height
                          child: CachedNetworkImage(
                            imageUrl: unit.introImage ??
                                "https://via.placeholder.com/317x117",
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 317.w,
                                height: 200.h,
                                color: Colors.white, // Placeholder color
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          top: 120.h, // Use ScreenUtil for position
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.6),
                              // Use ScreenUtil for radius
                            ),
                            padding: EdgeInsets.all(
                                8.w), // Use ScreenUtil for padding
                            child: Text(
                              unit.unitTitle ?? "",
                              style: GoogleFonts.montserrat(
                                fontSize: 20.sp, // Use ScreenUtil for font size

                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          )
        : SizedBox(
            height: 300.h,
            child: Center(
              child: Text(
                'No Data',
                style: AppStyles.mediumTitleStyle,
              ),
            ),
          );
  }
}

class TestimonialListView extends StatelessWidget {
  TestimonialListView({Key? key, required this.testimonials});
  final List<Testimonial> testimonials;

  @override
  Widget build(BuildContext context) {
    print(testimonials);

    return testimonials.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: testimonials.map((testimonial) {
              return Padding(
                padding: EdgeInsets.all(8.w), // Use ScreenUtil for padding
                child: TestimonialCard(
                  fullName: testimonial.fullName ?? '',
                  testimonial: testimonial.testimonial ?? '',
                  profilePictureUrl: testimonial.profilePicture ?? '',
                  dateTime: testimonial.dateTime.toString(),
                ),
              );
            }).toList(),
          )
        : SizedBox(
            height: 300.h,
            child: Center(
              child: Text(
                'No Data',
                style: AppStyles.mediumTitleStyle,
              ),
            ),
          );
  }
}
