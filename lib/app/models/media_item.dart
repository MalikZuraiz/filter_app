
class MediaItem {
  final int? id; // For SQLite primary key
  final String filePath; // Path to the media (image/video) in local storage
  final MediaType mediaType; // Enum for image or video
  final String? filterName; // Name of the applied filter (if any)
  final DateTime createdAt; // Date and time when the media was created
  final String? description; // Optional description (e.g., for memory feature)
  
  MediaItem({
    this.id,
    required this.filePath,
    required this.mediaType,
    this.filterName,
    required this.createdAt,
    this.description,
  });

  // Convert MediaItem to a Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'filePath': filePath,
      'mediaType': mediaType.toString(),
      'filterName': filterName,
      'createdAt': createdAt.toIso8601String(),
      'description': description,
    };
  }

  // Create MediaItem from a Map (SQLite row)
  factory MediaItem.fromMap(Map<String, dynamic> map) {
    return MediaItem(
      id: map['id'] as int?,
      filePath: map['filePath'] as String,
      mediaType: MediaType.values.firstWhere((e) => e.toString() == map['mediaType']),
      filterName: map['filterName'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
      description: map['description'] as String?,
    );
  }
}

enum MediaType {
  image,
  video,
}
