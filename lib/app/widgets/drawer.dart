import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noahrealstate/app/config/color_constant.dart';
import 'package:noahrealstate/app/config/styles.dart';
import 'package:noahrealstate/app/modules/home/controllers/home_controller.dart';

class AppDrawer extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorConstants.darkScaffoldBackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: ColorConstants.primaryColor,
            ),
            child: Column(
              children: [
                CircleAvatar(
                    radius: 40.r,
                    backgroundImage:
                        AssetImage('assets/images/noah-launcher.png')),
                Text(
                  'Noah Real Estates',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Home', style: AppStyles.drawerTextStyle),
            leading: Icon(
              Icons.home_outlined,
              color: ColorConstants.lightScaffoldBackgroundColor,
            ),
            selected: controller.selectedIndex.value == 0,
            onTap: () => controller.selectItem(0),
          ),
           ListTile(
            title: Text('Active Projects', style: AppStyles.drawerTextStyle),
            leading: Icon(
              Icons.change_circle_outlined,
              color: ColorConstants.lightScaffoldBackgroundColor,
            ),
            selected: controller.selectedIndex.value == 0,
            onTap: () => controller.selectItem(7),
          ),
          ListTile(
            title: Text('Projects', style: AppStyles.drawerTextStyle),
            leading: Icon(
              Icons.construction_outlined,
              color: ColorConstants.lightScaffoldBackgroundColor,
            ),
            selected: controller.selectedIndex.value == 0,
            onTap: () => controller.selectItem(6),
          ),
          ListTile(
            title: Text('Updates', style: AppStyles.drawerTextStyle),
            leading: Icon(
              Icons.update_outlined,
              color: ColorConstants.lightScaffoldBackgroundColor,
            ),
            selected: controller.selectedIndex.value == 0,
            onTap: () => controller.selectItem(1),
          ),
          ListTile(
            title: Text('About Us', style: AppStyles.drawerTextStyle),
            leading: Icon(
              Icons.info_outlined,
              color: ColorConstants.lightScaffoldBackgroundColor,
            ),
            selected: controller.selectedIndex.value == 0,
            onTap: () => controller.selectItem(2),
          ),
          ListTile(
            title: Text('Contact Us', style: AppStyles.drawerTextStyle),
            leading: Icon(
              Icons.contact_page,
              color: ColorConstants.lightScaffoldBackgroundColor,
            ),
            selected: controller.selectedIndex.value == 0,
            onTap: () => controller.selectItem(5),
          ),
        ],
      ),
    );
  }
}
