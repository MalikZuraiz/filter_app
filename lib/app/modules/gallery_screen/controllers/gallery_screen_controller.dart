import 'package:filterapp/app/models/media_item.dart';
import 'package:filterapp/config/app_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:io';

class GalleryScreenController extends GetxController {
  final RxList<MediaItem> memories = <MediaItem>[].obs;
  final RxList<MediaItem> feeds = <MediaItem>[].obs;
  final RxList<MediaItem> filteredMemories = <MediaItem>[].obs;
  final RxList<MediaItem> filteredFeeds = <MediaItem>[].obs;
  var isGridView = false.obs;
  var searchQuery = ''.obs;

  final AppDatabase _appDatabase = AppDatabase();

  @override
  void onInit() {
    super.onInit();
    _loadMemories();
    _loadFeeds();
  }

  // Example method to update search query
  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterMediaItems(query);
  }

  void filterMediaItems(String query) {
    // Logic to filter memories and feeds based on query
    filteredMemories.value = memories.where((item) {
      return item.filterName!.toLowerCase().contains(query.toLowerCase()) ||
          item.description!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    filteredFeeds.value = feeds.where((item) {
      return item.filterName!.toLowerCase().contains(query.toLowerCase()) ||
          item.description!.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  Future<void> _loadMemories() async {
    try {
      final allMediaItems = await _appDatabase.fetchAllMediaItems();
      final recentMemories = allMediaItems
          .where((item) => item.createdAt != null)
          .toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

      memories.assignAll(recentMemories.take(10));
      filteredMemories.assignAll(recentMemories.take(10));
    } catch (e) {
      Get.snackbar('Error', 'Failed to load memories: $e');
    }
  }

  Future<void> _loadFeeds() async {
    try {
      final allMediaItems = await _appDatabase.fetchAllMediaItems();
      feeds.assignAll(allMediaItems);
      filteredFeeds.assignAll(allMediaItems);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load feeds: $e');
    }
  }

  void toggleView() {
    isGridView.value = !isGridView.value;
  }

  void openMedia(MediaItem? media) {
    if (media == null) {
      Get.snackbar('Error', 'No media item selected');
      return;
    }
    Get.toNamed('/viewer-screen', arguments: media);
  }

  void searchMedia(String query) {
    final lowerQuery = query.toLowerCase();

    final filteredMemoryResults = memories.where((item) {
      return item.filterName!.toLowerCase().contains(lowerQuery) ||
          item.description!.toLowerCase().contains(lowerQuery) ||
          (item.createdAt.toString().contains(lowerQuery));
    }).toList();

    final filteredFeedResults = feeds.where((item) {
      return item.filterName!.toLowerCase().contains(lowerQuery) ||
          item.description!.toLowerCase().contains(lowerQuery) ||
          (item.createdAt.toString().contains(lowerQuery));
    }).toList();

    filteredMemories.assignAll(filteredMemoryResults);
    filteredFeeds.assignAll(filteredFeedResults);
  }

  Future<String?> generateVideoThumbnail(String videoPath) async {
    try {
      final thumbnail = await VideoThumbnail.thumbnailFile(
        video: videoPath,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 128,
        maxHeight: 128,
        quality: 75,
      );
      return thumbnail;
    } catch (e) {
      Get.snackbar('Error', 'Failed to generate thumbnail: $e');
      return null;
    }
  }

  // Save media item to gallery and database
  Future<void> saveMediaItem(String filePath) async {
    await AppDatabase().saveToGallery(filePath);
    Get.snackbar('Action', 'Media saved to gallery and database');
  }

  // Delete media item from the database and directory
  Future<void> deleteMediaItem(int id) async {
    await AppDatabase().deleteMediaItem(id);
    _loadFeeds(); // Reload the feeds after deletion
    _loadMemories();
    Get.snackbar('Action', 'Media deleted');
  }

Future<void> shareMedia(BuildContext context, String filePath) async {
  try {
    final file = File(filePath);
    if (!await file.exists()) {
      Get.snackbar('Error', 'File does not exist: $filePath');
      return;
    }

    final box = context.findRenderObject() as RenderBox?;
    if (box == null) {
      Get.snackbar('Error', 'Unable to determine share position');
      return;
    }

    await Share.shareXFiles(
      [XFile(filePath)],
      text: 'Check out this media!',
      subject: 'Media Sharing',
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  } catch (e) {
    Get.snackbar('Error', 'Failed to share media: $e');
  }
}

}