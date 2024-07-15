import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noahrealstate/app/config/color_constant.dart';
import 'package:noahrealstate/app/config/styles.dart';

class ApiErrorWidget extends StatelessWidget {
  const ApiErrorWidget(
      {super.key,
      required this.message,
      required this.retryAction,
      this.padding});

  final String message;
  final Function retryAction;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/noconnection.jpg'),
            Padding(
              padding:  EdgeInsets.only(bottom: 20.h),
              child: Text(message,style: GoogleFonts.montserrat(),),
            ),
            SizedBox(
                width: double.infinity,
                child: InkWell(
                  onTap: () => retryAction(),
                  child: Container(
                      height: 40.h,
                      color: ColorConstants.primaryColor,
                      child:  Center(child: Text('Retry',style: AppStyles.drawerTextStyle.copyWith(color: ColorConstants.darkButton, fontSize: 14.sp),))),
                )),
          ],
        ),
      ),
    );
  }
}
