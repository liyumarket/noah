import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:noahrealstate/app/widgets/drawer.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        toolbarHeight: 100,
        scrolledUnderElevation: 0.0,

          title: const Text('Settings'),
          centerTitle: true,
        ),
        drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 375,
              height: 812,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: Color(0xFFF9F9FA)),
              child: Stack(
                children: [
                  Positioned(
                    left: 27,
                    top: 130,
                    child: Container(
                      width: 330,
                      height: 85,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        shadows: [
                          BoxShadow(
                            color: Color(0x03000000),
                            blurRadius: 3,
                            offset: Offset(1, 1),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 97,
                    top: 163,
                    child: Container(
                      width: 250.18,
                      height: 21,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Text(
                              'Preferred language',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFBEC2C7),
                                fontSize: 18,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 173.95,
                            top: 0,
                            child: Text(
                              'English',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF363C45),
                                fontSize: 18,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 17,
                    top: 137,
                    child: Container(
                      width: 330,
                      height: 85,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        shadows: [
                          BoxShadow(
                            color: Color(0x03000000),
                            blurRadius: 3,
                            offset: Offset(1, 1),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 26,
                    top: 501,
                    child: Container(
                      width: 323,
                      height: 55,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 44,
                            top: 37,
                            child: Opacity(
                              opacity: 0.25,
                              child: Container(
                                width: 236,
                                height: 18,
                                decoration: ShapeDecoration(
                                  color: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2)),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 323,
                              height: 48,
                              decoration: ShapeDecoration(
                                color: Color(0xFF151414),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 110,
                    top: 169,
                    child: Container(
                      width: 246.83,
                      height: 21,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Text(
                              'Measurement unit',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFBEC2C7),
                                fontSize: 18,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 206.10,
                            top: 0,
                            child: Text(
                              ' ft²',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF363C45),
                                fontSize: 18,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 167,
                    top: 514,
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
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
}
