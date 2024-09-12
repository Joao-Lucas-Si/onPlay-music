import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:onPlay/models/song.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:wallpaper_handler/wallpaper_handler.dart';

class WallpaperService {
  setWallpaper(Song song, double width, double height) async {
    // print((await WallpaperHandler.instance
    //         .getWallpaper(WallpaperLocation.homeScreen))
    //     ?.buffer);
    final dir = await getTemporaryDirectory();

    if (song.picture != null) {
      var file = File(p.join(dir.path, "wallpaper.png"));

      file = await file.writeAsBytes(song.picture!);

      final result = await WallpaperHandler.instance.setWallpaperFromFile(
        file.path,
        WallpaperLocation.homeScreen,
      );
      print(result);
    }
  }
}
