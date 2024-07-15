import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noahrealstate/app/config/color_constant.dart';
import 'package:noahrealstate/app/config/styles.dart';
import 'package:noahrealstate/app/data/model/data_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class Propertycard extends StatelessWidget {
  Propertycard({Key? key, required this.property}) : super(key: key);
  final Property property;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 160.w,
          height: 170.h,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 6,
                offset: Offset(3, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 178.w,
                height: 60.h,
                child: CachedNetworkImage(
                  imageUrl: property.introImage ?? '',
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(color: Colors.white),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w, top: 5.h, bottom: 7.h),
                child: Text(
                  property.title ?? '',
                  textAlign: TextAlign.start,
                  style: AppStyles.cardTitleStyle.copyWith(fontSize: 14.sp),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16.sp,
                      color: ColorConstants.primaryColor,
                    ),
                    SizedBox(width: 10.w),
                    Flexible(
                      child: Text(
                        property.location ?? '',
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.visible,
                        style: AppStyles.cardsubTitleStyle
                            .copyWith(fontSize: 12.sp),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  children: [
                    Icon(
                      Icons.key_outlined,
                      size: 16.sp,
                      color: ColorConstants.primaryColor,
                    ),
                    SizedBox(width: 10.w),
                    Flexible(
                      child: Text(
                        DateFormat.yMMMEd().format(property.dateTime!),
                        textAlign: TextAlign.start,
                        style: AppStyles.cardsubTitleStyle
                            .copyWith(fontSize: 12.sp),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
