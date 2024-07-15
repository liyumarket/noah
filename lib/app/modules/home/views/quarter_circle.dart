import 'package:flutter/material.dart';
import 'package:noahrealstate/app/config/color_constant.dart';


class QuarterCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(size.width, 0) // Start at the top-right corner
      ..arcToPoint(
        Offset(0, size.height), // Arc to the bottom-left corner
        radius: Radius.circular(size.width),
        clockwise: false,
      )
      ..lineTo(size.width, size.height) // Draw a line to the bottom-right corner
      ..lineTo(size.width, 0) // Draw a line back to the start
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class QuarterCircleContainer extends StatelessWidget {
  final double size;

  QuarterCircleContainer({required this.size});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: QuarterCircleClipper(),
      child: Container(
        width: size,
        height: size,
        color: ColorConstants.primaryColor, // Change the color as needed
      ),
    );
  }
}
