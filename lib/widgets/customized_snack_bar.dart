// import 'package:bolo/config/app_colors.dart';
// import 'package:bolo/config/app_text_style.dart';
// import 'package:elegant_notification/elegant_notification.dart';
// import 'package:elegant_notification/resources/arrays.dart';
// import 'package:elegant_notification/resources/stacked_options.dart';
// import 'package:flutter/material.dart';

// class SnackbarUtils {
//   static void showSnackbar({
//     required String title,
//     required String message,
//     required BuildContext context,
//     Color backgroundColor =
//         Colors.red, // Optional background color with default
//   }) {
//     ElegantNotification.error(
//       width: 360,
//       stackedOptions: StackedOptions(
//         key: 'topLeft',
//         type: StackedType.below,
//         itemOffset: const Offset(0, 5),
//       ),
//       position: Alignment.topRight,
//       animation: AnimationType.fromRight,
//       title: Text(
//         title,
//         style: AppTextStyles.labelMediumRegular
//             .copyWith(color: AppColors.RED_COLOR),
//       ),
//       description: Text(
//         message,
//         style: AppTextStyles.labelSmallRegular
//             .copyWith(color: AppColors.BLACK_COLOR),
//       ),
//       onDismiss: () {},
//     ).show(context);
//   }
// }
