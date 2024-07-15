import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noahrealstate/app/config/color_constant.dart';
import 'package:noahrealstate/app/modules/home/views/expandable_text.dart';
import 'package:noahrealstate/app/modules/home/views/testimonial_view.dart';

class TestimonialCard extends StatelessWidget {
  final String fullName;
  final String testimonial;
  final String profilePictureUrl;
  final String videoUrl;

  final DateTime dateTime;

  TestimonialCard({
    required this.fullName,
    required this.testimonial,
    required this.profilePictureUrl,
    required this.dateTime,
    required this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 200.w,
      height: 220.h,
      child: Padding(
        padding: EdgeInsets.all(10.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundImage: CachedNetworkImageProvider(
                profilePictureUrl,
              ),
            ),
            // SizedBox(height: 5.h),

            Text(
              fullName,
              style:GoogleFonts.montserrat(
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            // SizedBox(height: 5.h),
            Text(
              testimonial,
              overflow: TextOverflow.visible,
              style: GoogleFonts.montserrat(fontSize: 10.sp),
              maxLines: 2,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TestimonialView(
                              fullName: fullName,
                              testimonial: testimonial,
                              profilePictureUrl: profilePictureUrl,
                              date: dateTime,
                              videoUrl: videoUrl,
                            )));
              },
              child: Text(
                'Read more',
                style: GoogleFonts.montserrat(color: ColorConstants.primaryColor),
              ),
            ),
// Adjust the spacing between cards if needed
          ],
        ),
      ),
    );
  }
}
