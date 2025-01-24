// import 'package:bolo/widgets/customized_reuse_button.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// void showCustomDialog(BuildContext context, VoidCallback onSureTap,
//     RxBool isLoading, String title, String image) {
//   final ThemeData theme = Theme.of(context);
//   final TextTheme textTheme = theme.textTheme;
//   showDialog(
//     context: context,
//     barrierDismissible:
//         true, // Allows dialog to be dismissed by tapping outside
//     builder: (BuildContext context) {
//       return AlertDialog(
//         contentPadding: const EdgeInsets.all(16), // Set padding around content
//         backgroundColor: theme.colorScheme.surface, // Dialog background color
//         content: Column(
//           mainAxisSize: MainAxisSize.min, // Size dialog to fit content
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(top: 16.0),
//               child: Image.asset(
//                 image,
//                 width: 115,
//                 height: 115,
//               ),
//             ),
//             const SizedBox(height: 16), // Add spacing between image and text
//             Text(
//               title,
//               textAlign: TextAlign.center,
//               style: textTheme.labelMedium!.copyWith(
//                 fontWeight: FontWeight.bold,
//                 color: theme.colorScheme.onSurfaceVariant,
//               ),
//             ),
//             const SizedBox(height: 32), // Add spacing between text and buttons
//             Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 32.0),
//                   child: CustomButton(
//                     buttonText: 'CANCEL',
//                     isLoading: RxBool(false),
//                     onTap: () {
//                       Get.back();
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 8), // Add spacing between buttons
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 32.0),
//                   child: CustomButton(
//                     buttonText: 'Sure',
//                     textColor: theme.colorScheme.onPrimary,
//                     backgroundColor: theme.colorScheme.primary,
//                     fontSize: 14,
//                     fontFamily: 'Poppins',
//                     fontWeight: FontWeight.bold,
//                     onTap: () {
//                       onSureTap();
//                     },
//                     isLoading: isLoading,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
