// import 'package:flutter/material.dart';
// import 'package:fluxstore/app/routes/app_pages.dart';
// import 'package:fluxstore/config/app_colors.dart';
// import 'package:fluxstore/config/app_images.dart';
// import 'package:fluxstore/config/app_text_style.dart';
// import 'package:fluxstore/widgets/customized_reuse_button.dart';
// import 'package:get/get.dart';
// import '../controllers/welcome_controller.dart';

// class WelcomeView extends GetView<WelcomeController> {
//   const WelcomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final double height = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: Stack(
//         children: [
//           _buildBackgroundImage(height),
//           _buildDimEffectOverlay(height),
//           _buildContent(height),
//         ],
//       ),
//     );
//   }

//   Widget _buildBackgroundImage(double height) {
//     return SizedBox(
//       height: height,
//       width: double.infinity,
//       child: Image.asset(
//         AppImages.WELCOME_IMAGE,
//         fit: BoxFit.cover,
//       ),
//     );
//   }

//   Widget _buildDimEffectOverlay(double height) {
//     return Container(
//       height: height,
//       width: double.infinity,
//       color: Colors.black.withOpacity(0.5),
//     );
//   }

//   Widget _buildContent(double height) {
//     return Positioned(
//       top: height * 0.7,
//       left: 0,
//       right: 0,
//       child: Column(
//         children: [
//           _buildHeading(),
//           SizedBox(height: height * 0.01),
//           _buildSubHeading(),
//           SizedBox(height: height * 0.06),
//           _buildGetStartedButton(),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeading() {
//     return Text(
//       'Welcome to GemStore!',
//       style: AppTextStyles.labelLargeMedium.copyWith(
//           fontWeight: FontWeight.bold,
//           fontSize: 32,
//           color: AppColors.WHITE_COLOR),
//       textAlign: TextAlign.center,
//     );
//   }

//   Widget _buildSubHeading() {
//     return const Text(
//       'Let\'s get started on your journey',
//       style: TextStyle(
//         fontSize: 18,
//         color: Colors.white,
//       ),
//       textAlign: TextAlign.center,
//     );
//   }

//   // Use the custom button class
//   Widget _buildGetStartedButton() {
//     return CustomButton(
//       text: 'Get Started',
//       borderWidth: 2.0, // Set 2px border width
//       // borderColor: Colors.white, // Set border color to white
//       onTap: () {
//         Get.offAllNamed(Routes.ONBOARDING);
//         // Handle button tap (e.g., navigate to another screen)
//       },
//     );
//   }
// }
