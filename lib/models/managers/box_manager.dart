import 'package:flutter/foundation.dart';
import 'package:onPlay/database/objectbox.dart';
import 'package:onPlay/models/managers/album_manager.dart';
import 'package:onPlay/models/managers/artist_manager.dart';
import 'package:onPlay/models/managers/genre_manager.dart';
import 'package:onPlay/models/managers/song_manager.dart';

class BoxManager extends ChangeNotifier {
  late AlbumManager albumManager;
  late SongManager songManager;
  late ArtistManager artistManager;
  late GenreManager genreManager;
  var started = false;

  BoxManager() {
    getBoxs();
  }

  getBoxs() async {
    final objectBox = await ObjectBox.create();
    albumManager = AlbumManager(objectBox.albumBox);
    songManager = SongManager(objectBox.boxSong);
    artistManager = ArtistManager(objectBox.artistBox);
    genreManager = GenreManager(objectBox.genreBox);
    started = true;
    notifyListeners();
  }
}
