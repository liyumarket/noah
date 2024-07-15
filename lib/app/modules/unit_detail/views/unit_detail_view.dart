import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noahrealstate/app/config/color_constant.dart';
import 'package:noahrealstate/app/data/model/data_model.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/unit_detail_controller.dart';

class UnitDetailView extends GetView<UnitDetailController> {
  UnitDetailView({Key? key}) : super(key: key);
  String removeHtmlTags(String htmlString) {
    final regExp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(regExp, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        toolbarHeight: 60.h,
      backgroundColor: Colors.grey.shade100,

        scrolledUnderElevation: 0.0,
        title: Text(
          controller.unit.unitTitle ?? 'Noah Real State',
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
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.gray,
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                    child: Stack(
                      children: [
                        controller.unit.photos!.isNotEmpty
                            ? ImageSlideshow(
                                width: double.infinity,
                                height: 300.h,
                                initialPage: 0,
                                indicatorColor: ColorConstants.primaryColor,
                                indicatorBackgroundColor: Colors.grey,
                                autoPlayInterval: 3000,
                                isLoop: true,
                                children: controller.unit.photos!
                                    .map(
                                      (image) =>CachedNetworkImage(
                                          imageUrl:
                                              image ?? '',
                                          placeholder: (context, url) =>
                                              Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: Container(
                                              color: Colors.white,
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
                      ],
                    ),
                  ),
                  Container(
                    width: 321.w,
                    margin: EdgeInsets.only(top: 20.h),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Color(0xFFE5E8EC)),
                        borderRadius: BorderRadius.circular(6.w),
                      ),
                      shadows: [
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
                            style:GoogleFonts.montserrat(
                              color: Color(0xFF363C45),
                              fontSize: 16.sp,
                              
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.w),
                          child: Text(
                            removeHtmlTags(controller.unit.description ?? ''),
                            style: GoogleFonts.montserrat(
                              color: Color(0xFF363C45),
                              fontSize: 16.sp,
                              
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                    child: Text(
                      'Floor Plan',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF363C45),
                        fontSize: 20.sp,
                        
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.gray,
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                    child: Stack(
                      children: [
                        controller.unit.floorPlans!.isNotEmpty
                            ? ImageSlideshow(
                                width: double.infinity,
                                height: 300.h,
                                initialPage: 0,
                                indicatorColor: ColorConstants.primaryColor,
                                indicatorBackgroundColor: Colors.grey,
                                autoPlayInterval: 3000,
                                isLoop: true,
                                children: controller.unit.floorPlans!
                                    .map(
                                      (image) => Image.network(
                                        image! ?? '',
                                        fit: BoxFit.cover,
                                        width: 350.w,
                                      ),
                                    )
                                    .toList(),
                              )
                            : Container(
                                height: 300.h,
                                child: Center(
                                  child: Text('No plan found.'),
                                ),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  AmenitiesList(
                    amenities: controller.unit.apartmentAmenities ?? [],
                    feature: controller.unit.features,
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AmenitiesList extends StatelessWidget {
  final List<String> amenities;
  final String? feature;

  const AmenitiesList({Key? key, required this.amenities, this.feature})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 321.w,
  
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.w, color: Color(0xFFE5E8EC)),
          borderRadius: BorderRadius.circular(6.w),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 2.w,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FEATURES',
              style: GoogleFonts.montserrat(
                color: ColorConstants.primaryColor,
                fontSize: 16.sp,
               
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              width: 293.w,
              child: Text(
                feature ?? '',
                style: GoogleFonts.montserrat(
                  color: Color(0xFF363C45),
                  fontSize: 16.sp,
                  
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'AMENITIES',
              style: GoogleFonts.montserrat(
                color: ColorConstants.primaryColor,
                fontSize: 16.sp,
              
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: amenities.map((amenity) {
                return Text(
                  '- $amenity',
                  style:GoogleFonts.montserrat(
                    color: Color(0xFF363C45),
                    fontSize: 16.sp,
                   
                    fontWeight: FontWeight.w400,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
