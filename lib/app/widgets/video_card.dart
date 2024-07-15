import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoCard extends StatelessWidget {
  final String url;
  final String name;

  VideoCard({Key? key, required this.url, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120.w,
      height: 90.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: url,
            imageBuilder: (context, imageProvider) => Container(
              width: 120.w,
              height: 80.h,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(3, 3),
                  ),
                ],
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 120.w,
                height: 80.h,
                color: Colors.white, // Placeholder color
              ),
            ),
            errorWidget: (context, url, error) => Container(
                color: Colors.white,
                width: 120.w,
                height: 80.h,
                child: const Icon(Icons.error)),
          ),
          Text(
            name ?? "",
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
