import 'dart:io';
import 'package:filterapp/app/models/media_item.dart';
import 'package:filterapp/config/app_db.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:deepar_flutter/deepar_flutter.dart';

class HomeScreenController extends GetxController {
  final deepArController = DeepArController();
  final AppDatabase _appDatabase = AppDatabase();

  int selectedFilterIndex = -1;
  File? screenshotFile;
  bool _isRecording = false;

  // Switch effect (filter)
  void switchEffect(String effectFile, int index) {
    selectedFilterIndex = index;
    deepArController.switchEffect(effectFile);
    update(); // Update the UI after filter change
  }

  // Take screenshot and save it
  Future<void> takeScreenshot() async {
    screenshotFile = await deepArController.takeScreenshot();

    if (screenshotFile != null) {
      final directory = await getExternalStorageDirectory();
      final filterMeDir = Directory('${directory?.path}/Pictures/filterMe');
      if (!await filterMeDir.exists()) {
        await filterMeDir.create(recursive: true);
      }

      final fileName =
          'screenshot_${DateTime.now().millisecondsSinceEpoch}.png';
      final filePath = '${filterMeDir.path}/$fileName';
      await screenshotFile!.copy(filePath);

      // Save the media item to the database
      MediaItem mediaItem = MediaItem(
        filePath: filePath,
        mediaType: MediaType.image,
        filterName: 'filter_$selectedFilterIndex',
        createdAt: DateTime.now(),
        description: 'No Caption',
      );

      int id = await _appDatabase.insertMediaItem(mediaItem);
      debugPrint('Media Item saved in DB with ID: $id');
      Get.snackbar('Shot captured successfully.', 'Shot captured successfully');
    }
  }

  // Start video recording
  Future<void> startVideoRecording() async {
    try {
      await deepArController.startVideoRecording();
      _isRecording = true;
    } catch (e) {
      debugPrint('Error starting video recording: $e');
    }
  }

  // Stop video recording
  Future<void> stopVideoRecording() async {
    if (!_isRecording) return;

    try {
      File videoFile = await deepArController.stopVideoRecording();

      final directory = await getExternalStorageDirectory();
      final filterMeDir = Directory('${directory?.path}/Pictures/filterMe');
      if (!await filterMeDir.exists()) {
        await filterMeDir.create(recursive: true);
      }

      final fileName = 'video_${DateTime.now().millisecondsSinceEpoch}.mp4';
      final filePath = '${filterMeDir.path}/$fileName';
      await videoFile.copy(filePath);

      // Save the media item to the database
      MediaItem mediaItem = MediaItem(
        filePath: filePath,
        mediaType: MediaType.video,
        filterName: 'filter_$selectedFilterIndex',
        createdAt: DateTime.now(),
        description: 'Video recorded',
      );

      await _appDatabase.insertMediaItem(mediaItem);
      Get.snackbar('Video saved', 'Video saved');
    } catch (e) {
      debugPrint('Error stopping video recording: $e');
    } finally {
      _isRecording = false;
    }
  }

  // Flip the camera
  void flipCamera() {
    deepArController.flipCamera();
  }

  // Toggle the flashlight
  void toggleFlash() {
    deepArController.toggleFlash();
  }
}
