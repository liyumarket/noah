import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noahrealstate/app/config/color_constant.dart';
import 'package:noahrealstate/app/routes/app_pages.dart';
import 'package:noahrealstate/app/widgets/drawer.dart';
import '../controllers/abouts_controller.dart';

class AboutsView extends GetView<AboutsController> {
  const AboutsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(Routes.HOME);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
          toolbarHeight: 60.h,
          scrolledUnderElevation: 0.0,
          title: Text(
            'About Us',
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        drawer: AppDrawer(),
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
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: ColorConstants.primaryColor,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 30.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About Noah',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Image.asset(
                                width: 300.w,
                                height: 160.h,
                                'assets/images/about.png'),
                            Text(
                              'Noah Real Estate PLC. was established in 2013 G.C. and have since delivered 20 residential and 5 commercial, and 8 mixed use mid to large scale projects, with additional 14 projects under development at various sites in Addis Ababa.\n\nNoah is a highly esteemed company with a strong financial foundation and state-of-the-art design innovation. This combination enables us to construct powerful visions and has the potential to evoke an immediate desire to tour the interior.',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 30.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'WHY NOAH',
                              style: GoogleFonts.montserrat(
                                color: ColorConstants.primaryColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              'Noah is a sister company of Great Abyssinia PLC, a renowned FMCG company with brands you love, such as Abyssinia Coffee, Prigat, Tulip, and Aby soda drinks with various flavors. In a recent prestigious deal, we are also partnered up with Nestlé in water bottling; a continuation of the Abyssinia Springs brand.',
                              style: GoogleFonts.montserrat(
                                color: Color(0xFF707070),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 30.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'WHAT WE DO',
                              style: GoogleFonts.montserrat(
                                color: ColorConstants.primaryColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Image.asset(
                                width: 300.w,
                                height: 160.h,
                                fit:BoxFit.fitWidth,
                                'assets/images/about2.png'),
                            Text(
                              'Founded in 2013, Noah Real Estate PLC has successfully delivered 16 residential, 5 commercial, and 8 mixed-use projects, with 14 more under development across Addis Ababa. Over the past decade, we have constructed and continue to build a total of 31 projects, solidifying our reputation as a leading brand in the real estate sector.\n\nOur commitment to excellence is evident in our bold vision and state-of-the-art design innovations. We strive to significantly contribute to the real estate sector, focusing on "Design, Build, and Deliver." This motto reflects our dedication to providing an exceptional buying experience, developing, acquiring, and managing properties with a responsible selling approach.\n\nAt Noah Real Estate, we ensure each project is completed to the highest standards before offering it for sale. Our mission is to become synonymous with quality performance in design, construction, and delivery, making us a trusted and capable partner in the real estate market.',
                              style: GoogleFonts.montserrat(
                                color: Color(0xFF707070),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
