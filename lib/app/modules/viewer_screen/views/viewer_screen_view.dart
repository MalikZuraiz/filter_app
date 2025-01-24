import 'dart:io';
import 'package:filterapp/app/models/media_item.dart';
import 'package:filterapp/app/modules/viewer_screen/controllers/viewer_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:better_player/better_player.dart';
import 'dart:developer' as dev;

class ViewerScreenView extends GetView<ViewerScreenController> {
  const ViewerScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    dev.log('Building ViewerScreenView');
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Builder(
              builder: (context) {
                final mediaItem = controller.mediaItem;
                dev.log('Media item in view:', error: {
                  'hasMedia': mediaItem != null,
                  'mediaType': mediaItem?.mediaType.toString(),
                  'filePath': mediaItem?.filePath,
                });

                if (mediaItem == null) {
                  return const Center(
                    child: Text(
                      'No media item available',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                if (mediaItem.mediaType == MediaType.image) {
                  return _buildImageView(mediaItem.filePath);
                } else if (mediaItem.mediaType == MediaType.video) {
                  return _buildVideoView();
                } else {
                  return const Center(
                    child: Text(
                      'Unsupported media type',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageView(String filePath) {
    return Image.file(
      File(filePath),
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        dev.log('Image loading error:', error: error, stackTrace: stackTrace);
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text(
                'Failed to load image\n$error',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVideoView() {
    return FutureBuilder<bool>(
      future: controller.initializeVideoPlayer(controller.mediaItem!.filePath),
      builder: (context, snapshot) {
        dev.log('Video FutureBuilder state:', error: {
          'connectionState': snapshot.connectionState.toString(),
          'hasError': snapshot.hasError,
          'hasData': snapshot.hasData,
          'error': snapshot.error?.toString(),
        });

        if (snapshot.connectionState == ConnectionState.waiting ||
            controller.isVideoLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text(
                  'Failed to load video\n${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          );
        }

        if (!snapshot.hasData || controller.videoController == null) {
          return const Center(
            child: Text(
              'Video unavailable',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return _buildVideoPlayer();
      },
    );
  }

  Widget _buildVideoPlayer() {
    if (controller.videoController == null) return const SizedBox.shrink();

    return Center(
      child: AspectRatio(
        aspectRatio: 16 / 9, // BetterPlayer will adjust this automatically
        child: BetterPlayer(controller: controller.videoController!),
      ),
    );
  }
}