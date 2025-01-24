import 'dart:async';
import 'dart:developer' as dev;
import 'dart:io';
import 'package:filterapp/app/models/media_item.dart';
import 'package:filterapp/config/app_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:better_player/better_player.dart';

class ViewerScreenController extends GetxController {
  MediaItem? mediaItem;
  BetterPlayerController? videoController;
  var isVideoPlaying = false.obs;
  var isVideoLoading = true.obs;
  final AppDatabase _appDatabase = AppDatabase();

  @override
  void onInit() {
    super.onInit();
    dev.log('ViewerScreenController: onInit called');
    _initializeMedia();
  }

  Future<void> _initializeMedia() async {
    try {
      mediaItem = Get.arguments;
      dev.log('Media Arguments Check:', error: {
        'mediaItem': mediaItem?.toString(),
        'filePath': mediaItem?.filePath,
        'mediaType': mediaItem?.mediaType.toString(),
      });

      if (mediaItem == null) {
        dev.log('ERROR: No media item found in arguments');
        return;
      }

      if (isValidVideoFormat(mediaItem!.filePath)) {
        await initializeVideoPlayer(mediaItem!.filePath);
      }
    } catch (e, stackTrace) {
      dev.log('Error in _initializeMedia', error: e, stackTrace: stackTrace);
    }
  }

  bool isValidVideoFormat(String filePath) {
    final lowercasePath = filePath.toLowerCase();
    final isValid = lowercasePath.endsWith('.mp4') || 
                    lowercasePath.endsWith('.mov') || 
                    lowercasePath.endsWith('.mkv');
    dev.log('Video format check:', error: {
      'path': filePath,
      'isValid': isValid,
      'extension': filePath.split('.').last
    });
    return isValid;
  }

  Future<bool> initializeVideoPlayer(String filePath) async {
    try {
      dev.log('Starting video player initialization');
      isVideoLoading.value = true;

      if (videoController != null) {
        videoController!.dispose();
      }

      final file = File(filePath);
      if (!await file.exists()) {
        throw Exception('Video file does not exist: $filePath');
      }

      // Configure BetterPlayer
      final betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.file,
        filePath,
        cacheConfiguration: const BetterPlayerCacheConfiguration(
          useCache: true,
          preCacheSize: 10 * 1024 * 1024, // 10MB
          maxCacheSize: 100 * 1024 * 1024, // 100MB
          maxCacheFileSize: 10 * 1024 * 1024, // 10MB
        ),
      );

      final betterPlayerConfiguration = BetterPlayerConfiguration(
        autoPlay: false,
        looping: false,
        fit: BoxFit.contain,
        controlsConfiguration: const BetterPlayerControlsConfiguration(
          enablePlayPause: true,
          
          enableSkips: true,
          enableFullscreen: true,
          showControlsOnInitialize: true,
          loadingColor: Colors.white,
          progressBarPlayedColor: Colors.red,
          progressBarHandleColor: Colors.red,
        ),
        placeholder: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );

      videoController = BetterPlayerController(
        betterPlayerConfiguration,
        betterPlayerDataSource: betterPlayerDataSource,
      );

      videoController!.addEventsListener(_videoPlayerListener);

      await videoController!.setupDataSource(betterPlayerDataSource);

      dev.log('Video initialized successfully');
      
      isVideoLoading.value = false;
      update();
      return true;

    } catch (e, stackTrace) {
      dev.log('Error in video initialization', error: e, stackTrace: stackTrace);
      _handleVideoError('Failed to initialize video: $e');
      return false;
    }
  }

  void _videoPlayerListener(BetterPlayerEvent event) {
    if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
      isVideoPlaying.value = false;
    } else if (event.betterPlayerEventType == BetterPlayerEventType.play) {
      isVideoPlaying.value = true;
    } else if (event.betterPlayerEventType == BetterPlayerEventType.pause) {
      isVideoPlaying.value = false;
    }
  }

  void _handleVideoError(String message) {
    isVideoLoading.value = false;
    videoController?.dispose();
    videoController = null;
    update();
    Get.snackbar(
      'Video Error',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 5),
    );
  }

  void toggleVideoPlayback() {
    if (videoController == null) {
      dev.log('ERROR: Video controller is null during playback toggle');
      return;
    }

    try {
      if (isVideoPlaying.value) {
        videoController!.pause();
      } else {
        videoController!.play();
      }
    } catch (e, stackTrace) {
      dev.log('Error in toggleVideoPlayback', error: e, stackTrace: stackTrace);
      Get.snackbar(
        'Playback Error',
        'Failed to control video playback',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> shareMedia(BuildContext context, String filePath) async {
    dev.log('Sharing media from file: $filePath');
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        dev.log('File does not exist: $filePath');
        Get.snackbar('Error', 'File does not exist');
        return;
      }

      final box = context.findRenderObject() as RenderBox?;
      if (box == null) {
        dev.log('Unable to determine share position');
        Get.snackbar('Error', 'Unable to share at this time');
        return;
      }

      await Share.shareXFiles(
        [XFile(filePath)],
        text: 'Check out this media!',
        subject: 'Media Sharing',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
      );
    } catch (e) {
      dev.log('Error while sharing media: $e');
      Get.snackbar('Error', 'Failed to share media');
    }
  }

  Future<void> onDownload() async {
    try {
      dev.log('Downloading media: ${mediaItem?.filePath}');
      await _appDatabase.saveToGallery(mediaItem?.filePath ?? '');
      Get.snackbar('Success', 'Media downloaded successfully');
    } catch (error) {
      dev.log('Error downloading media: $error');
      Get.snackbar('Error', 'Failed to download media');
    }
  }

  void onEdit() {
    try {
      Get.toNamed('/edit-image-screen', arguments: mediaItem);
    } catch (error) {
      dev.log('Error navigating to edit screen: $error');
      Get.snackbar('Error', 'Failed to open editor');
    }
  }

  @override
  void onClose() {
    try {
      dev.log('Disposing video controller');
      videoController?.removeEventsListener(_videoPlayerListener);
      videoController?.dispose();
    } catch (e, stackTrace) {
      dev.log('Error in onClose', error: e, stackTrace: stackTrace);
    }
    super.onClose();
  }
}