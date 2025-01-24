// import 'package:bolo/widgets/customized_textfield.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:bolo/widgets/customized_reuse_button.dart'; // Import your CustomButton

// void showEditableFieldAlert(
//   BuildContext context, {
//   required String heading,
//   required String detail,
//   required TextEditingController textController,
//   required String hintText,
//   String? successText,
//   required VoidCallback onConfirm,
//   required VoidCallback onCancel,
//   required RxBool isLoading, // Observable for loading state
// }) {
//   final ThemeData theme = Theme.of(context);
//   final TextTheme textTheme = theme.textTheme;

//   showDialog(
//     context: context,
//     barrierDismissible: false, // Prevent dismissing by tapping outside
//     builder: (BuildContext context) {
//       return AlertDialog(
//         contentPadding: const EdgeInsets.all(16),
//         backgroundColor: theme.colorScheme.surface,
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 heading,
//                 style: textTheme.labelMedium!.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: theme.colorScheme.onSurfaceVariant,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               detail,
//               style: textTheme.labelSmall!.copyWith(
//                 color: theme.colorScheme.onSurface,
//               ),
//             ),
//             const SizedBox(height: 16),
//             CustomTextFields(
//               hintText: hintText,
//               controller: textController,
//               successText: successText,
//             ),
//             const SizedBox(height: 32),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: CustomButton(
//                       buttonText: 'Cancel',
//                       isLoading: RxBool(false),
//                       onTap: () {
//                         textController.clear(); // Clear the text controller
//                         Navigator.of(context).pop(); // Close dialog
//                         onCancel(); // Call cancel callback
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: CustomButton(
//                       buttonText: 'Confirm',
//                       textColor: theme.colorScheme.onPrimary,
//                       backgroundColor: theme.colorScheme.primary,
//                       fontSize: 14,
//                       fontFamily: 'Poppins',
//                       fontWeight: FontWeight.bold,
//                       onTap: () {
//                         if (!isLoading.value) {
//                           isLoading.value = true;
//                           Future.microtask(() {
//                             Navigator.of(context)
//                                 .pop(); // Close dialog only if no error
//                             onConfirm(); // Call confirm callback
//                           });
//                         }
//                       },
//                       isLoading: isLoading,
//                     ),
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
