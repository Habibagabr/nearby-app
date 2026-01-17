import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MyImageCacheManager {
  static const key = "nearbyPlacesCache";

  static final CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 1), // Delete if not accessed for 1 day
      maxNrOfCacheObjects: 50,             // Keep only the 50 most recent images
      repo: JsonCacheInfoRepository(databaseName: key),
      fileService: HttpFileService(),
    ),
  );
}
