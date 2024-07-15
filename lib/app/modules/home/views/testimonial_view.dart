import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noahrealstate/app/config/color_constant.dart';
import 'package:noahrealstate/app/config/styles.dart';
import 'package:noahrealstate/app/modules/home/views/expandable_text.dart';
import 'package:noahrealstate/app/modules/home/views/pixel_by_pixel.dart';
import 'package:noahrealstate/app/routes/app_pages.dart';

class TestimonialView extends StatelessWidget {
  final String fullName;
  final String testimonial;
  final String profilePictureUrl;
  final String videoUrl;

  final DateTime date;

  TestimonialView({
    required this.fullName,
    required this.testimonial,
    required this.profilePictureUrl,
    required this.date,
    required this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        toolbarHeight: 60.h,
        scrolledUnderElevation: 0.0,
        title: Text(
          'Testimonial',
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
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(14.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60.r,
                    backgroundImage: CachedNetworkImageProvider(
                      profilePictureUrl,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    fullName,
                    style: GoogleFonts.montserrat(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  InkWell(
                    onTap: () {
                      // Handle video button press
                      if (videoUrl != '') {
                        Get.toNamed(Routes.VIDEO_PLAYER_SCREEN,
                            arguments: videoUrl);
                      } else {
                        FirebaseAnalytics.instance.logEvent(
                          name: "get_data",
                          parameters: {
                            "content_type": "link",
                            "data_length":
                                'No video link found for $fullName testimony',
                          },
                        );
                        Get.snackbar(
                          'No Video Found',
                          'There is no video link available for this update.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red.withOpacity(0.8),
                          colorText: Colors.white,
                        );
                      }
                    },
                    child: Container(
                      height: 40.h,
                      width: 100.w,
                      color: ColorConstants.primaryColor,
                      child: Center(
                        child: Text(
                          'See Video',
                          style: AppStyles.cardTitleStyle
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    testimonial,
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Text(
                          date.toString().substring(0, 10),
                          textAlign: TextAlign.right,
                          style: GoogleFonts.montserrat(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
