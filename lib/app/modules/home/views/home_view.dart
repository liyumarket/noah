import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:noahrealstate/app/config/color_constant.dart';
import 'package:noahrealstate/app/config/styles.dart';
import 'package:noahrealstate/app/data/model/data_model.dart';
import 'package:noahrealstate/app/modules/home/views/bottom_sheet.dart';
import 'package:noahrealstate/app/modules/home/views/testimonial_card.dart';
import 'package:noahrealstate/app/routes/app_pages.dart';
import 'package:noahrealstate/app/widgets/api_error_widget.dart';
import 'package:noahrealstate/app/widgets/drawer.dart';
import 'package:noahrealstate/app/widgets/property_card.dart';
import 'package:noahrealstate/app/widgets/video_card.dart';
import 'package:noahrealstate/app/widgets/widget_animation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  final TextEditingController searchController = TextEditingController();

  void filterProperties() {
    final query = searchController.text.toLowerCase();
    final filteredProperties = controller.data?.where((property) {
          return property.title!.toLowerCase().contains(query);
        }).toList() ??
        [];
    searchController.clear();
    FirebaseAnalytics.instance.logEvent(
        name: 'filter data with name $query and moved to search result screen');

    Get.toNamed(
      Routes.VIEWALLPROPERTIES,
      arguments: {'data': filteredProperties, 'hasDrawer': false},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        toolbarHeight: 60.h,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.grey.shade100,
        title: Text(
          'Explore',
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                controller.loadData(true);
              },
              icon: Icon(
                Icons.refresh_outlined,
                size: 25.sp,
              ))
        ],
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
          GetBuilder<HomeController>(builder: (_) {
            return MyWidgetsAnimator(
              apiCallStatus: controller.apiCallStatus,
              loadingWidget: () => const Center(
                child: CupertinoActivityIndicator(),
              ),
              errorWidget: () => ApiErrorWidget(
                message: 'An error occurred\n       Try Again.',
                retryAction: () => controller.loadData(true),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
              ),
              successWidget: () => Stack(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 200.h,
                        height: 200.h,
                        decoration: BoxDecoration(
                          color: ColorConstants.primaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(200.h),
                          ),
                        ),
                      )),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 330.w,
                      child: CustomScrollView(
                        slivers: [
                          SliverPadding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.h, horizontal: 5.w),
                            sliver: SliverToBoxAdapter(
                              child: SearchBar(
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ),
                                controller: searchController,
                                leading: const Icon(Icons.search,
                                    color: Color(0xffB5B8BC)),
                                hintText: 'search property',
                                trailing: [
                                  IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const FilterBottomSheet();
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      Icons.filter_alt,
                                      color: ColorConstants.primaryColor,
                                    ),
                                  ),
                                ],
                                onSubmitted: (value) {
                                  filterProperties();
                                },
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Addis Ababa',
                                  style: AppStyles.mediumTitleStyle,
                                ),
                                Text(
                                  DateFormat('EEEE, d MMMM yyyy')
                                      .format(DateTime.now()),
                                  style: AppStyles.mediumSubtitleStyle,
                                ),
                              ],
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.only(right: 24.w, top: 24.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Featured Projects',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: HorizontalPropertyListView(
                              properties: controller.filteredProperties ?? [],
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.only(right: 24.w, top: 8.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Updates',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: HorizontalVideoListView(
                              properties: controller.updatedProperties ?? [],
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.only(right: 24.w, top: 8.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Testimonials',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: HorizontalTestimonyListView(
                              testimonials: controller.testimonials ?? [],
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding:
                                  EdgeInsets.only(right: 24.w, bottom: 16.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Projects',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => Get.toNamed(
                                        Routes.VIEWALLPROPERTIES,
                                        arguments: {
                                          'data': controller.data,
                                          'hasDrawer': false,
                                        }),
                                    child: Text(
                                      'View All',
                                      style: GoogleFonts.montserrat(
                                        color: ColorConstants.primaryColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10.h,
                              crossAxisSpacing: 16.w,
                              childAspectRatio: 0.81,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () => Get.toNamed(
                                      Routes.PROPERTY_DETAIL,
                                      arguments: controller.data![index]),
                                  child: Propertycard(
                                      property: controller.data![index]),
                                );
                              },
                              childCount: controller.data!.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class HorizontalTestimonyListView extends StatelessWidget {
  HorizontalTestimonyListView({super.key, required this.testimonials});
  List<Testimonial> testimonials;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.all(0.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Padding(
                    padding:
                        EdgeInsets.only(right: 16.w, top: 16.h, bottom: 4.h),
                    child: TestimonialCard(
                      fullName: testimonials[index].fullName ?? '',
                      testimonial: testimonials[index].testimonial ?? '',
                      profilePictureUrl:
                          testimonials[index].profilePicture ?? '',
                      dateTime: testimonials[index].dateTime ?? DateTime.now(),
                      videoUrl: testimonials[index].videoLink ?? '',
                    ),
                  );
                },
                childCount: testimonials.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalVideoListView extends StatelessWidget {
  HorizontalVideoListView({super.key, required this.properties});
  List<Property> properties;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135.h,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.all(0.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 16.w, top: 16.h),
                    child: InkWell(
                        onTap: () => Get.toNamed(Routes.UPDATE_DETAIL,
                            arguments: properties[index].updates),
                        child: VideoCard(
                          url: properties[index].introImage ?? '',
                          name: properties[index].title ?? '',
                        )),
                  );
                },
                childCount: properties.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalPropertyListView extends StatelessWidget {
  HorizontalPropertyListView({super.key, required this.properties});
  List<Property> properties;

  @override
  Widget build(BuildContext context) {
    return properties.isNotEmpty
        ? SizedBox(
            height: 220.h,
            child: CustomScrollView(
              scrollDirection: Axis.horizontal,
              slivers: <Widget>[
                SliverPadding(
                  padding: EdgeInsets.only(top: 16.h),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 18.w),
                          child: InkWell(
                            onTap: () => Get.toNamed(Routes.PROPERTY_DETAIL,
                                arguments: properties[index]),
                            child: Propertycard(property: properties[index]),
                          ),
                        );
                      },
                      childCount: properties.length,
                    ),
                  ),
                ),
              ],
            ),
          )
        : Center(
            child: Text(
              'No Data',
              style: AppStyles.mediumTitleStyle,
            ),
          );
  }
}
