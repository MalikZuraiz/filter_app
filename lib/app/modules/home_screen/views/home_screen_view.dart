import 'dart:io';
import 'package:filterapp/app/routes/app_pages.dart';
import 'package:filterapp/constants.dart';
import 'package:filterapp/config/app_filter_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deepar_flutter/deepar_flutter.dart';
import '../controllers/home_screen_controller.dart';

class HomePage extends GetView<HomeScreenController> {
  HomePage({super.key});

//  final deepArController = DeepArController();

  Future<void> initializeController() async {
    await controller.deepArController.initialize(
      androidLicenseKey: licenseKey,
      iosLicenseKey: '',
      resolution: Resolution.high,
    );
  }

  Widget buildButtons(HomeScreenController controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: controller.flipCamera,
            icon: const Icon(
              Icons.settings,
              size: 25,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: controller.flipCamera,
            icon: const Icon(
              Icons.flip_camera_ios_outlined,
              size: 25,
              color: Colors.white,
            ),
          ),
          GestureDetector(
            onDoubleTap: () => controller.takeScreenshot(),
  
            onLongPressStart: (_) {
              controller.startVideoRecording();
            },
            onLongPressEnd: (_) {
              controller.stopVideoRecording();
            },
            child: FilledButton(
              onPressed:
                  () {}, // Empty since we're using GestureDetector for interaction
              child: const Icon(Icons.camera,size: 36,),
            ),
          ),
          IconButton(
            onPressed: controller.toggleFlash,
            icon: const Icon(
              Icons.flash_on,
              size: 25,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.GALLERY_SCREEN);
            },
            icon: const Icon(
              Icons.image,
              size: 25,
              color: Colors.white,
            ),
          ),
        ],
      );

  Widget buildCameraPreview() => SizedBox(
        height: Get.size.height * 0.82,
        child: Transform.scale(
          scale: 1.5,
          child: DeepArPreview(controller.deepArController),
        ),
      );

  Widget buildFilters() => SizedBox(
        height: Get.size.height * 0.1,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            itemBuilder: (context, index) {
              final filter = filters[index];
              final effectFile =
                  File('assets/filters/${filter.filterPath}').path;
              return InkWell(
                onTap: () =>
                    controller.deepArController.switchEffect(effectFile),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        image:
                            AssetImage('assets/previews/${filter.imagePath}'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              );
            }),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: initializeController(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildCameraPreview(),
                buildButtons(controller),
                buildFilters(),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
