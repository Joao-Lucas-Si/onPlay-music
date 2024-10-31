import 'package:flutter/foundation.dart';
import 'package:onPlay/database/objectbox.dart';
import 'package:onPlay/models/managers/album_manager.dart';
import 'package:onPlay/models/managers/artist_manager.dart';
import 'package:onPlay/models/managers/genre_manager.dart';
import 'package:onPlay/models/managers/interface_manager.dart';
import 'package:onPlay/models/managers/layout_manager.dart';
import 'package:onPlay/models/managers/playlist_manager.dart';
import 'package:onPlay/models/managers/settings_manager.dart';
import 'package:onPlay/models/managers/share_manager.dart';
import 'package:onPlay/models/managers/song_manager.dart';
import 'package:onPlay/models/managers/user_manager.dart';

class BoxManager extends ChangeNotifier {
  late AlbumManager albumManager;
  late SongManager songManager;
  late ArtistManager artistManager;
  late InterfaceManager interfaceManager;
  late ShareManager shareManager;
  late LayoutManager layoutManager;
  late GenreManager genreManager;
  late UserManager userManager;
  late PlaylistManager playlistManager;
  late SettingsManager settingsManager;
  var started = false;

  BoxManager({notify = true}) {
    if (notify) getBoxs(notify: notify);
  }

  Future<BoxManager> getBoxs({notify = true}) async {
    final objectBox = await ObjectBox.create();
    albumManager = AlbumManager(objectBox.albumBox);
    songManager = SongManager(objectBox.boxSong);
    interfaceManager = InterfaceManager(objectBox.interfaceSettingsBox);
    artistManager = ArtistManager(objectBox.artistBox);
    genreManager = GenreManager(objectBox.genreBox);
    userManager = UserManager(objectBox.userBox);
    layoutManager = LayoutManager(objectBox.layoutSettingsBox);
    shareManager = ShareManager(objectBox.shareSettingsBox);
    settingsManager = SettingsManager(objectBox.settingsBox);
    playlistManager = PlaylistManager(objectBox.playlistBox);
    started = true;
    if (notify) notifyListeners();
    return this;
  }
}
