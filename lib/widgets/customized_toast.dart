// import 'package:bolo/config/app_colors.dart';
// import 'package:bolo/config/app_text_style.dart';
// import 'package:flutter/material.dart';

// class CustomToast {
//   static void showToast(BuildContext context, String message) {
//     final overlay = Overlay.of(context);
//     final overlayEntry = OverlayEntry(
//       builder: (context) {
//         return _ToastWidget(
//           message: message,
//         );
//       },
//     );

//     overlay.insert(overlayEntry);

//     Future.delayed(const Duration(seconds: 3), () {
//       overlayEntry.remove();
//     });
//   }
// }

// class _ToastWidget extends StatelessWidget {
//   final String message;

//   const _ToastWidget({required this.message});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedPositioned(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//       bottom: 50.0,
//       left: MediaQuery.of(context).size.width * 0.1,
//       width: MediaQuery.of(context).size.width * 0.8,
//       child: AnimatedOpacity(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//         opacity: 1.0,
//         child: Material(
//           color: Colors.transparent,
//           child: Container(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//             decoration: BoxDecoration(
//               color: Colors.black.withOpacity(0.8),
//               borderRadius: BorderRadius.circular(4.0), // Square border
//             ),
//             child: Text(
//               message,
//               style: AppTextStyles.labelSmallRegular.copyWith(
//                 fontSize: 14,
//                 color: AppColors.DARK_WHITE_COLOR,
//               ),
//               textAlign: TextAlign.left,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
