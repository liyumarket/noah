import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noahrealstate/app/config/color_constant.dart';
import 'package:noahrealstate/app/config/styles.dart';
import 'package:noahrealstate/app/modules/home/controllers/home_controller.dart';
import 'package:noahrealstate/app/routes/app_pages.dart';
import 'package:noahrealstate/app/widgets/drawer.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/updates_controller.dart';

class UpdatesView extends GetView<UpdatesController> {
  UpdatesView({Key? key}) : super(key: key);
  HomeController homeController = Get.find();
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
          toolbarHeight: 60.h,
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.grey.shade100,
          title: Text(
            'Updates',
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
            homeController.updatedProperties == null
                ? Center(
                    child: Text(
                      'No Data',
                      style: AppStyles.mediumTitleStyle,
                    ),
                  )
                : homeController.updatedProperties!.isEmpty
                    ? Center(
                        child: Text(
                        'No Updates yet',
                        style: GoogleFonts.montserrat(),
                      ))
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: CustomScrollView(
                          slivers: <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6.h, horizontal: 6.w),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                                0.1), // Shadow color
                                            spreadRadius: 2, // Spread radius
                                            blurRadius: 5, // Blur radius
                                            offset: Offset(0,
                                                3), // Offset in the x and y direction
                                          ),
                                        ],
                                      ),
                                      child: ListTile(
                                        style: ListTileStyle.drawer,
                                        onTap: () {
                                          Get.toNamed(Routes.UPDATE_DETAIL,
                                              arguments: homeController
                                                      .updatedProperties![index]
                                                      .updates ??
                                                  []);
                                        },
                                        contentPadding: EdgeInsets.zero,
                                        title: Row(
                                          children: [
                                            Container(
                                              width: 100.w,
                                              height: 70.h,
                                              child: CachedNetworkImage(
                                                imageUrl: homeController
                                                        .updatedProperties![
                                                            index]
                                                        .introImage ??
                                                    '',
                                                placeholder: (context, url) =>
                                                    Shimmer.fromColors(
                                                  baseColor: Colors.grey[300]!,
                                                  highlightColor:
                                                      Colors.grey[100]!,
                                                  child: Container(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    homeController
                                                            .updatedProperties![
                                                                index]
                                                            .title ??
                                                        "",
                                                    style: AppStyles
                                                        .cardTitleStyle
                                                        .copyWith(
                                                            fontSize: 16.sp),
                                                  ),
                                                  Text(
                                                    homeController
                                                            .updatedProperties![
                                                                index]
                                                            .dateTime
                                                            .toString()
                                                            .substring(0, 10) ??
                                                        '',
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    style: AppStyles
                                                        .cardsubTitleStyle
                                                        .copyWith(
                                                            fontSize: 14.sp),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        // subtitle:
                                        trailing: Padding(
                                          padding: EdgeInsets.only(right: 8.w),
                                          child: Text(
                                            '${homeController.updatedProperties![index].projectProgress ?? "0"} %',
                                            style: AppStyles.cardTitleStyle
                                                .copyWith(
                                                    fontSize: 16.sp,
                                                    color: ColorConstants
                                                        .primaryColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                childCount:
                                    homeController.updatedProperties!.length,
                              ),
                            )
                          ],
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
