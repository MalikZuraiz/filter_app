import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share_plus/share_plus.dart';  // For sharing functionality
import '../app/models/media_item.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  static Database? _database;

  AppDatabase._internal();

  factory AppDatabase() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/media_items.db';

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(''' 
          CREATE TABLE media_items(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            filePath TEXT,
            mediaType TEXT,
            filterName TEXT,
            createdAt TEXT,
            description TEXT
          )
        ''');

      },
    );
  }

  Future<int> insertMediaItem(MediaItem mediaItem) async {
    final db = await database;
    int id = await db.insert('media_items', mediaItem.toMap());

    // // Save the media item to the gallery (only after saving to the database)
    // if (mediaItem.mediaType == MediaType.image) {
    //   await _saveToGallery(mediaItem.filePath);
    // } else if (mediaItem.mediaType == MediaType.video) {
    //   await _saveToGallery(mediaItem.filePath);
    // }
    
    return id;
  }

  Future<List<MediaItem>> fetchAllMediaItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('media_items');

    return List.generate(maps.length, (i) {
      return MediaItem.fromMap(maps[i]);
    });
  }

  Future<int> deleteMediaItem(int id) async {
    final db = await database;
    MediaItem? mediaItemToDelete = await _fetchMediaItemById(id);
    if (mediaItemToDelete != null) {      
      // Remove file from the directory
      await _deleteFromDirectory(mediaItemToDelete.filePath);
    }

    return await db.delete('media_items', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateMediaItem(MediaItem mediaItem) async {
    final db = await database;
    return await db.update(
      'media_items',
      mediaItem.toMap(),
      where: 'id = ?',
      whereArgs: [mediaItem.id],
    );
  }

  Future<void> closeDatabase() async {
    final db = await database;
    await db.close();
  }

  // Helper method to save media files to the gallery
  Future<void> saveToGallery(String filePath) async {
    final result = await ImageGallerySaver.saveFile(filePath);
    debugPrint('File saved to gallery: $result');
    Get.snackbar('Media saved to gallery', 'Media saved to gallery');
  }

  // Helper method to delete file from the directory
  Future<void> _deleteFromDirectory(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
      debugPrint('File deleted from directory: $filePath');
      Get.snackbar('File Deleted from gallery', 'File Deleted from gallery');

    } else {
      debugPrint('File does not exist in the directory: $filePath');
    }

  }
  Future<void> shareMedia(String filePath, String mediaType) async {
    final File file = File(filePath);

    if (await file.exists()) {
      await Share.shareXFiles([XFile(filePath)], text: 'Sharing $mediaType');
    } else {
      Get.snackbar('Error', 'File does not exist: $filePath');
    }
  }


  // Helper method to fetch media item by ID
  Future<MediaItem?> _fetchMediaItemById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('media_items',
        where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return MediaItem.fromMap(maps.first);
    }
    return null;
  }
}
