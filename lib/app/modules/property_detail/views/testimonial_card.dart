import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class TestimonialCard extends StatelessWidget {
  final String fullName;
  final String testimonial;
  final String profilePictureUrl;
  final String dateTime;

  TestimonialCard({
    required this.fullName,
    required this.testimonial,
    required this.profilePictureUrl,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.r),
      child: Padding(
          padding: EdgeInsets.all(10.r),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CircleAvatar(
              radius: 35.r,
              backgroundImage: CachedNetworkImageProvider(
                profilePictureUrl,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fullName,
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    testimonial,
                    style:GoogleFonts.montserrat(fontSize: 14.sp),
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}
