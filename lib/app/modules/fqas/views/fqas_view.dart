import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:noahrealstate/app/widgets/drawer.dart';

import '../controllers/fqas_controller.dart';

class FqasView extends GetView<FqasController> {
  const FqasView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        toolbarHeight: 100,

          title: const Text('FQAs'),
          centerTitle: true,
        ),
        drawer: AppDrawer(),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
              width: 375,
              height: 800,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(color: Color(0xFFFAFAFB)),
              child: Stack(children: [
                const Positioned(
                  left: 27,
                  top: 30,
                  child: Text(
                    'HomeIN F.A.Q.',
                    style: TextStyle(
                      color: Color(0xFFDD5B26),
                      fontSize: 40,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w900,
                      height: 0.03,
                    ),
                  ),
                ),
                const Positioned(
                  left: 26,
                  top: 100,
                  child: SizedBox(
                    width: 324,
                    height: 94,
                    child: Text(
                      'These are the questions.',
                      style: TextStyle(
                          color: Color(0xFF535C67),
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 0.07,
                          overflow: TextOverflow.clip),
                    ),
                  ),
                ),
                Positioned(
                  left: 27,
                  top: 159,
                  child: Container(
                    width: 323,
                    height: 60,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 0.50, color: Color(0xFFE0E0E0)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x29000000),
                          blurRadius: 0.50,
                          offset: Offset(0, 1),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        ' lobortis finibus nibh?',
                        style: TextStyle(
                          color: Color(0xFF363C45),
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 0.09,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 30,
                  child: Container(
                      width: 323,
                      height: 55,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF151414),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      child: const Center(
                        child: Text(
                          'Contact us',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0.09,
                          ),
                        ),
                      )),
                ),
              ])),
        ])));
  }
}
