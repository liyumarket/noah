// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:noahrealstate/app/data/model/data_model.dart';
// import 'package:shimmer/shimmer.dart';

// class AppartmentCard extends StatelessWidget {
//   AppartmentCard({
//     Key? key,
//     required this.apartment,
//     required this.location,
//     required this.title,
//   }) : super(key: key);

//   final Apartment apartment;
//   final String? title;
//   final String? location;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 160.w, // Adjusted width to fit two cards in a row
//       height: 120.h,
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.3),
//             blurRadius: 4,
//             offset: Offset(3, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//         Container(
//   width: 160.w,
//   height: 100.h,
  // child: CachedNetworkImage(
  //   imageUrl: apartment.introImage ?? "https://via.placeholder.com/160x117",
  //   placeholder: (context, url) => Shimmer.fromColors(
  //     baseColor: Colors.grey[300]!,
  //     highlightColor: Colors.grey[100]!,
  //     child: Container(
  //       width: 160.w,
  //       height: 100.h,
  //       color: Colors.white, // Placeholder color
  //     ),
  //   ),
  //   errorWidget: (context, url, error) => Icon(Icons.error),
  //   fit: BoxFit.cover,
  // ),
// ),
//  Container(
//             decoration: BoxDecoration(
//               color: Colors.black.withOpacity(0.6), // Darker transparent color
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(5.w),
//                 bottomRight: Radius.circular(5.w),
//               ),
//               border: Border.all(
//                 width: 0.5.w,
//                 color: Color(0xFFE0E0E0),
//               ),
//             ),
//             child: Padding(
//               padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 8.h),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Site: ${title ?? ''}',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 10.sp,
//                       fontFamily: 'Roboto',
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.fromLTRB(8.w, 8.h, 0, 0),
//             child: SizedBox(
//               height: 80.h,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     apartment.title ?? 'Noah Apartment',
//                     style: TextStyle(
//                       color: Color(0xFF363C45),
//                       fontSize: 16.sp,
//                       fontFamily: 'Roboto',
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   SizedBox(height: 8.h),
//                   Flexible(
//                     child: Text(
//                       apartment.description ?? "",
//                       overflow: TextOverflow.clip,
//                       style: TextStyle(
//                           color: Color(0xFFB0B4BE),
//                           fontSize: 16.sp,
//                           fontFamily: 'Roboto',
//                           fontWeight: FontWeight.w400,
//                           overflow: TextOverflow.fade),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
