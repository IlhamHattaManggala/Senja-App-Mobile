import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class VideoCacheManager {
  static final BaseCacheManager _instance = CacheManager(
    Config(
      'VideoCache',
      stalePeriod: const Duration(days: 7), // cache berlaku selama 7 hari
      maxNrOfCacheObjects: 20, // maksimal 20 file video
    ),
  );

  factory VideoCacheManager() {
    return VideoCacheManager._();
  }

  VideoCacheManager._();

  Future<FileInfo?> getFileFromCache(String url) {
    return _instance.getFileFromCache(url);
  }

  Future<File> getSingleFile(String url) async {
    return await _instance.getSingleFile(url);
  }

  Future<void> removeFile(String url) async {
    await _instance.removeFile(url);
  }

  Future<void> emptyCache() async {
    await _instance.emptyCache();
  }
}
