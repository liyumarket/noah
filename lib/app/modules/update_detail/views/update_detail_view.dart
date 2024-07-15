import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noahrealstate/app/config/color_constant.dart';
import 'package:noahrealstate/app/config/styles.dart';
import 'package:noahrealstate/app/routes/app_pages.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/update_detail_controller.dart';

class UpdateDetailView extends GetView<UpdateDetailController> {
  const UpdateDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        toolbarHeight: 60.h,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.grey.shade100,
        title: Text(
          'Detail Updates',
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
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
          controller.updates.isEmpty
              ? Center(
                  child: Text(
                    'No data',
                    style: GoogleFonts.montserrat(),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: controller.updates.map((update) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Intro Image
                          if (update.introImages != null)
                            CachedNetworkImage(
                              imageUrl: update.introImages ?? '',
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  color: Colors.white,
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                  color: Colors.white,
                                  height: 300.h,
                                  width: 500.w,
                                  child: Icon(Icons.error)),
                              fit: BoxFit.fill,
                              height: 300.h,
                              width: 500.w,
                            ),
                          SizedBox(height: 16.h),
                          // Status
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Row(
                              children: [
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: double.parse(update.status ?? '0') /
                                        100,
                                    backgroundColor: Colors.grey[300],
                                    color: ColorConstants.primaryColor,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text('${update.status}%',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 16.sp)),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          // Updates
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Date and Video Button
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      update.dateOfUpdate
                                          .toString()
                                          .substring(0, 10),
                                      style: GoogleFonts.montserrat(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (update.youtubeLink != null &&
                                            update.youtubeLink!.isNotEmpty) {
                                          Get.toNamed(
                                              Routes.VIDEO_PLAYER_SCREEN,
                                              arguments: update.youtubeLink);
                                        } else {
                                          FirebaseAnalytics.instance.logEvent(
                                            name: "get_data",
                                            parameters: {
                                              "content_type": "link",
                                              "data_length":
                                                  'No video link found for ${update.project}',
                                            },
                                          );
                                          Get.snackbar(
                                            'No Video Found',
                                            'There is no video link available for this update.',
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor:
                                                Colors.red.withOpacity(0.8),
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
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                // Images Grid
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8.w,
                                    mainAxisSpacing: 8.h,
                                  ),
                                  itemCount: update.images!.length,
                                  itemBuilder: (context, index) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(8.w),
                                      child: CachedNetworkImage(
                                        imageUrl: update.images![index] ?? '',
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
                                    );
                                  },
                                ),
                                SizedBox(height: 16.h),
                              ],
                            ),
                          )
                        ],
                      );
                    }).toList(),
                  ),
                ),
        ],
      ),
    );
  }
}
