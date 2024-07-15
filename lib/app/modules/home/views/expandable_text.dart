import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noahrealstate/app/config/color_constant.dart';
import 'package:noahrealstate/app/modules/home/views/testimonial_view.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  ExpandableText({required this.text});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          overflow: expanded ? TextOverflow.visible : TextOverflow.fade,
          style: TextStyle(fontSize: 10.sp),
          maxLines: expanded ? null : 2,
        ),
        if (!expanded)
          GestureDetector(
            onTap: () {
              setState(() {
                expanded = true;
              });
            },
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: 4.0.h),
              child: Text(
                'Read more',
                style: TextStyle(color: ColorConstants.primaryColor),
              ),
            ),
          ),
           
      ],
    );
  }
}