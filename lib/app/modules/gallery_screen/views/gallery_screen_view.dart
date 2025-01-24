import 'dart:io';
import 'package:filterapp/app/models/media_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/gallery_screen_controller.dart';

class GalleryScreenView extends GetView<GalleryScreenController> {
  const GalleryScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              await _showSearch(context);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Memories Carousel
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Memories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 150,
            child: Obx(() {
              final memories = controller.filteredMemories;
              if (memories.isEmpty) {
                return const Center(child: Text('No memories to show.'));
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: memories.length,
                itemBuilder: (context, index) {
                  final memory = memories[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: _buildMediaPreview(memory, 130),
                    ),
                  );
                },
              );
            }),
          ),

          // Your Feeds Section
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Feeds',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: controller.toggleView,
                  icon: Obx(() => Icon(
                        controller.isGridView.value
                            ? Icons.view_comfy
                            : Icons.view_agenda,
                      )),
                ),
              ],
            ),
          ),

          // Feeds Layout
          Expanded(
            child: Obx(() {
              final feeds = controller.filteredFeeds;
              if (feeds.isEmpty) {
                return const Center(child: Text('No feeds available.'));
              }

              return controller.isGridView.value
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      itemCount: feeds.length,
                      itemBuilder: (context, index) {
                        final feed = feeds[index];
                        return GestureDetector(
                          onTap: () => controller.openMedia(feed),
                          child: _buildMediaPreview(feed, 130),
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: feeds.length,
                      itemBuilder: (context, index) {
                        final feed = feeds[index];
                        return GestureDetector(
                          onTap: () => controller.openMedia(feed),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: _buildMediaPreview(feed, 60),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Filter: ${feed.filterName}',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        feed.description ?? 'No description available',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                // PopupMenuButton for actions
                                Builder(
                                  builder: (context) {
                                    return PopupMenuButton<String>(
                                      icon: const Icon(Icons.more_vert),
                                      onSelected: (value) {
                                        switch (value) {
                                          case 'save':
                                            controller.saveMediaItem(feed.filePath);
                                            break;
                                          case 'edit':
                                          Get.toNamed('/edit-image-screen', arguments: feed);
                                            break;
                                          case 'delete':
                                            controller.deleteMediaItem(feed.id!);
                                            break;
                                          case 'share':
                                            controller.shareMedia(
                                                context, feed.filePath);
                                            break;
                                        }
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return <PopupMenuEntry<String>>[
                                          const PopupMenuItem<String>(
                                            value: 'save',
                                            child: Text('Save'),
                                          ),
                                          const PopupMenuItem<String>(
                                            value: 'edit',
                                            child: Text('Edit'),
                                          ),
                                          const PopupMenuItem<String>(
                                            value: 'delete',
                                            child: Text('Delete'),
                                          ),
                                          const PopupMenuItem<String>(
                                            value: 'share',
                                            child: Text('Share'),
                                          ),
                                        ];
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
            }),
          ),
        ],
      ),
    );
  }

  // Method to show the search using SearchDelegate
  Future<void> _showSearch(BuildContext context) async {
    final query = await showSearch(
      context: context,
      delegate: MediaSearchDelegate(controller: controller),
    );
    if (query != null) {
      controller.updateSearchQuery(query);
    }
  }

  Widget _buildMediaPreview(MediaItem media, double size) {
    final thumbnailSize = size;
    if (media.filePath.endsWith('.mp4') || media.filePath.endsWith('.mov')) {
      return FutureBuilder<String?>(
        future: controller.generateVideoThumbnail(media.filePath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(snapshot.data!),
                      fit: BoxFit.cover,
                      width: thumbnailSize,
                      height: thumbnailSize,
                    ),
                  ),
                  const Icon(
                    Icons.play_circle_fill,
                    color: Colors.white,
                    size: 40,
                  ),
                ],
              );
            } else {
              return const Icon(Icons.video_collection); // Default video icon
            }
          }
          return const CircularProgressIndicator();
        },
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.file(
          File(media.filePath),
          fit: BoxFit.cover,
          width: thumbnailSize,
          height: thumbnailSize,
        ),
      );
    }
  }
}
class MediaSearchDelegate extends SearchDelegate<String> {
  final GalleryScreenController controller;

  MediaSearchDelegate({required this.controller});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(() {
        final results = controller.feeds.where((item) {
          final description = item.description?.toLowerCase() ?? '';
          final filterName = item.filterName?.toLowerCase() ?? '';
          final searchQuery = query.toLowerCase();

          return description.contains(searchQuery) ||
              filterName.contains(searchQuery);
        }).toList();

        if (results.isEmpty) {
          return const Center(
            child: Text('No results found'),
          );
        }

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final item = results[index];
            return ListTile(
              leading: SizedBox(
                width: 60,
                height: 60,
                child: _buildMediaPreview(item), // Use the helper function here
              ),
              title: Text(item.filterName ?? 'No filter'),
              subtitle: Text(
                item.description ?? 'No description',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                close(context, query);
                controller.openMedia(item);
              },
            );
          },
        );
      }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text('Start typing to search...'),
    );
  }

  // New helper function to build media preview (image or video thumbnail)
  Widget _buildMediaPreview(MediaItem media) {
    const thumbnailSize =
        120.0; // Unified size for both image and video thumbnails
    if (media.filePath.endsWith('.mp4') || media.filePath.endsWith('.mov')) {
      return FutureBuilder<String?>(
        future: controller.generateVideoThumbnail(media.filePath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(snapshot.data!),
                      fit: BoxFit.cover,
                      width: thumbnailSize,
                      height: thumbnailSize,
                    ),
                  ),
                  const Icon(
                    Icons.play_circle_fill,
                    color: Colors.black,
                    size: 25,
                  ),
                ],
              );
            } else {
              return const Icon(Icons.video_collection); // Default video icon
            }
          }
          return const CircularProgressIndicator();
        },
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.file(
          File(media.filePath),
          fit: BoxFit.cover,
          width: thumbnailSize,
          height: thumbnailSize,
        ),
      );
    }
  }
}