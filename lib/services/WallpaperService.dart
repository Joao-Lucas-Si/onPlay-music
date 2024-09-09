import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:onPlay/dto/song.dart';
import 'package:wallpaper_handler/wallpaper_handler.dart';

class WallpaperService {
  setWallpaper(Song song) async {
    // print((await WallpaperHandler.instance
    //         .getWallpaper(WallpaperLocation.homeScreen))
    //     ?.buffer);
    if (song.picture != null) {
      var file = await DefaultCacheManager()
          .getFileFromMemory(Image.memory(song.picture!).key.toString());
      // print(file?.file);
      if (file?.file != null) {
        final result = await WallpaperHandler.instance.setWallpaperFromFile(
            file!.file.path, WallpaperLocation.homeScreen);
        // print(result);
      }
    }
  }
}
