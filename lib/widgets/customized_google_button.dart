// import 'package:flutter/material.dart';
// import 'package:get/get.dart'; // Import GetX for RxBool
// import 'package:bolo/config/app_colors.dart';
// import 'package:bolo/config/app_images.dart';
// import 'package:bolo/config/app_text_style.dart';

// class GoogleLoginButton extends StatelessWidget {
//   final double screenHeight;
//   final double screenWidth;
//   final VoidCallback onTap;
//   final RxBool isLoading; // Add RxBool for loading state

//   const GoogleLoginButton({
//     Key? key,
//     required this.screenHeight,
//     required this.screenWidth,
//     required this.onTap,
//     required this.isLoading, // Initialize RxBool
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Obx(() => GestureDetector(
//             onTap: isLoading.value ? null : onTap, // Disable onTap if loading
//             child: Container(
//               width: screenWidth * 0.7, // Set width based on screen width
//               height:
//                   screenHeight * 0.06, // Set the height based on screen height
//               decoration: BoxDecoration(
//                 color: AppColors.LIGHTEST_BLUE_COLOR,
//                 borderRadius: BorderRadius.circular(
//                     screenHeight * 0.03), // Adjust border radius
//               ),
//               child: Center(
//                 child: isLoading.value
//                     ? const SizedBox(
//                         width: 29.0,
//                         height: 29.0,
//                         child: CircularProgressIndicator(
//                           valueColor: AlwaysStoppedAnimation<Color>(
//                               AppColors.GREY_COLOR),
//                         ),
//                       )
//                     : Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Image.asset(
//                             AppImages
//                                 .GOOGLE_ICON, // Replace with the path to your Google logo image
//                             width: screenWidth *
//                                 0.04, // Adjust width based on screen width
//                             height: screenHeight *
//                                 0.03, // Adjust height based on screen height
//                           ),
//                           SizedBox(width: screenWidth * 0.02),
//                           Text(
//                             'Connect with Google',
//                             style: AppTextStyles.dinNextMedium.copyWith(
//                               color: AppColors.BLACK_COLOR,
//                             ),
//                           ),
//                         ],
//                       ),
//               ),
//             ),
//           )),
//     );
//   }
// }
