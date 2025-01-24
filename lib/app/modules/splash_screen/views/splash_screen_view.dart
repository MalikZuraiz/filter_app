import 'package:filterapp/app/routes/app_pages.dart';
import 'package:filterapp/config/app_colors.dart';
import 'package:filterapp/config/app_images.dart';
import 'package:filterapp/config/app_text_style.dart';
import 'package:filterapp/widgets/customized_reuse_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
   @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundImage(height),
          _buildDimEffectOverlay(height),
          _buildContent(height),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(double height) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Image.asset(
        AppImages.WELCOME_IMAGE,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildDimEffectOverlay(double height) {
    return Container(
      height: height,
      width: double.infinity,
      color: Colors.black.withOpacity(0.6),
    );
  }

  Widget _buildContent(double height) {
    return Positioned(
      top: height * 0.7,
      left: 0,
      right: 0,
      child: Column(
        children: [
          _buildHeading(),
          SizedBox(height: height * 0.01),
          _buildSubHeading(),
          SizedBox(height: height * 0.03),
          _buildGetStartedButton(),
        ],
      ),
    );
  }

  Widget _buildHeading() {
    return Text(
      'Welcome to FilterMe',
      style: AppTextStyles.labelLargeMedium.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: AppColors.WHITE_COLOR),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubHeading() {
    return const Text(
      'Enhance your photos with stunning filters ',
      style: TextStyle(
        fontSize: 15,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }

  // Use the custom button class
  Widget _buildGetStartedButton() {
    return CustomButton(
      text: 'Start Now',
      width: 300,
      borderWidth: 1.0, // Set 2px border width
      // borderColor: Colors.white, // Set border color to white
      onTap: () {
        Get.offAllNamed(Routes.HOME_SCREEN);
        // Handle button tap (e.g., navigate to another screen)
      },
    );
  }
}
