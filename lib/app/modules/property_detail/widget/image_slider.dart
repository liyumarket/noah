import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Image extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 375.w,
          height: 400.h,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 375.w,
                  height: 400.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEEEEE),
                    border: Border.all(width: 1),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 375.w,
                  height: 400.h,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/375x400"),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(width: 1),
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