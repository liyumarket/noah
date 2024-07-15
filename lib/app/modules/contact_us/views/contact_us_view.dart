import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noahrealstate/app/config/color_constant.dart';
import 'package:noahrealstate/app/config/styles.dart';
import 'package:noahrealstate/app/routes/app_pages.dart';
import 'package:noahrealstate/app/widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/contact_us_controller.dart';

class Contact {
  final String name;
  final String building;
  final String email;
  final String phone;
  final String? image;

  Contact({
    required this.name,
    required this.building,
    required this.email,
    required this.phone,
    this.image,
  });
}

class ContactUsView extends GetView<ContactUsController> {
  ContactUsView({Key? key}) : super(key: key);

  final List<Contact> contacts = [
    Contact(
      name: "Bole Medhaniyalem",
      building: "Abyssinia Plaza, 12th floor",
      email: "info@noahrealestateplc.com",
      phone: "+25196100",
      image:
          "https://dev.noahrealestateplc.com/templates/yootheme/cache/4c/Abyssinia_Plaza_Cover-4c2cbe2c.webp",
    ),
    Contact(
      name: "Bole next to Alem Cinema",
      building: "Noah Plaza, 1st floor",
      email: "info@noahrealestateplc.com",
      phone: "+25196100",
      image:
          "https://dev.noahrealestateplc.com/templates/yootheme/cache/e2/Noah_Plaza_-_front_view_003-e25ccc97.webp",
    ),
  ];

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
          backgroundColor: Colors.grey.shade100,
          title: Text(
            'Contact Us',
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          scrolledUnderElevation: 0.0,
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
                  Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: SocialMediaRow(
                      icons: [
                        SocialMediaIcon(
                          icon: FontAwesomeIcons.facebook,
                          onTap: () {
                            // Handle LinkedIn tap
                            launchUrl(Uri.parse('https://www.facebook.com/noahrealestate'));
                          },
                        ),
                        SocialMediaIcon(
                          icon: FontAwesomeIcons.tiktok,
                          onTap: () {
                            launchUrl(Uri.parse('https://www.tiktok.com/@noah.real.estate'));
                            // Handle YouTube tap

                          },
                        ),
                        SocialMediaIcon(
                          icon: FontAwesomeIcons.linkedin,
                          onTap: () {
                            // Handle LinkedIn tap
                            launchUrl(Uri.parse('https://linkedin.com/company/noahrealestate'));

                          },
                        ),
                        SocialMediaIcon(
                          icon: FontAwesomeIcons.youtube,
                          onTap: () {
                            // Handle YouTube tap
                            launchUrl(Uri.parse('https://youtube.com/@noahrealestateofficial13'));

                          },
                        ),
                        SocialMediaIcon(
                          icon: FontAwesomeIcons.instagram,
                          onTap: () {
                            // Handle Instagram tap
                            launchUrl(Uri.parse('https://www.instagram.com/noahrealestateplc'));

                          },
                        ),
                        SocialMediaIcon(
                          icon: FontAwesomeIcons.twitter,
                          onTap: () {
                            // Handle Twitter tap
                            launchUrl(Uri.parse('https://x.com/NoahRealEstate'));
                            
                          },
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Locations",
                    style: AppStyles.drawerTextStyle
                        .copyWith(color: ColorConstants.darkButton),
                  ),
                  SizedBox(
                    height: 500.h,
                    child: ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        return _buildContactCard(contacts[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(Contact contact) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 18.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 5, // Blur radius
              offset: Offset(0, 3), // Offset in the x and y direction
            ),
          ],
        ),
        child: ListTile(
          //  leading: SizedBox(),
          leading: SizedBox(
              width: 125.w,
              child: Text(
                contact.name,
                style: AppStyles.mediumTitleStyle,
              )),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  children: [
                    Icon(Icons.location_pin,
                        color: ColorConstants.primaryColor),
                    SizedBox(width: 5.w),
                    Flexible(child: Text(contact.building)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: GestureDetector(
                  onTap: () async {
                    final emailUri = Uri(
                      scheme: 'mailto',
                      path: contact.email,
                    );
                    if (await canLaunchUrl(emailUri)) {
                      await launchUrl(emailUri);
                    } else {
                      throw 'Could not launch $emailUri';
                    }
                  },
                  child: Row(
                    children: [
                      Icon(Icons.email, color: ColorConstants.primaryColor),
                      SizedBox(width: 5.w),
                      Flexible(
                          child: Text(
                        contact.email,
                        style: GoogleFonts.montserrat(),
                      )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: GestureDetector(
                  onTap: () async {
                    final phoneUri = Uri(
                      scheme: 'tel',
                      path: contact.phone,
                    );
                    if (await canLaunchUrl(phoneUri)) {
                      await launchUrl(phoneUri);
                    } else {
                      throw 'Could not launch $phoneUri';
                    }
                  },
                  child: Row(
                    children: [
                      Icon(Icons.phone, color: ColorConstants.primaryColor),
                      SizedBox(width: 5.w),
                      Flexible(
                          child: Text(
                        contact.phone,
                        style: GoogleFonts.montserrat(),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialMediaRow extends StatelessWidget {
  final List<SocialMediaIcon> icons;

  const SocialMediaRow({Key? key, required this.icons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: icons,
    );
  }
}

class SocialMediaIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const SocialMediaIcon({Key? key, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        size: 30.sp,
        color: ColorConstants.primaryColor,
      ),
    );
  }
}
