import 'package:flutter/material.dart';
import 'package:noahrealstate/app/config/color_constant.dart';

class Searchbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 324,
          height: 52,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 324,
                  height: 52,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF9F9FA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                ),
              ),
               Positioned(
                left: 52,
                top: 16,
                child: Text(
                  'Search 162 property',
                  style: TextStyle(
                    color: ColorConstants.gray,
                    fontSize: 17,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w300,
                    height: 0,
                  ),
                ),
              ),
        ],
          ),
        ),
      ],
    );
  }
}