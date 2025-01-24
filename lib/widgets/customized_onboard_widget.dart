// import 'package:e_cycle/config/app_text_style.dart';
// import 'package:flutter/widgets.dart';

// class OnboardingPage extends StatelessWidget {
//   final String imagePath;
//   final String heading;
//   final String description;

//   const OnboardingPage({
//     required this.imagePath,
//     required this.heading,
//     required this.description,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Image.asset(
//           imagePath,
//           width: double.infinity,
//           height: 475,
//           fit: BoxFit.cover,
//         ),
//         const SizedBox(height: 100),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Text(
//             heading,
//             style: AppTextStyles.extraTitleLarge,
//             textAlign: TextAlign.center,
//           ),
//         ),
//         const SizedBox(height: 1),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Text(
//             description,
//             style: AppTextStyles.titleMedium.copyWith(fontSize: 21),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ],
//     );
//   }
// }
