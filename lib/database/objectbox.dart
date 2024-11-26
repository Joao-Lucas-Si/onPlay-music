import 'package:onPlay/database/objectbox.obx.dart';
import 'package:onPlay/models/album.dart';
import 'package:onPlay/models/artist.dart';
import 'package:onPlay/models/genre.dart';
import 'package:onPlay/models/playlist.dart';
import 'package:onPlay/models/settings/interface.dart';
import 'package:onPlay/models/settings/layout.dart';
import 'package:onPlay/models/settings/player.dart';
import 'package:onPlay/models/settings/settings.dart';
import 'package:onPlay/models/settings/share.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/models/user_profile.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  Box<Song> get boxSong => store.box<Song>();

  Box<DatabaseShareSettings> get shareSettingsBox =>
      store.box<DatabaseShareSettings>();

  Box<DatabaseLayoutSettings> get layoutSettingsBox =>
      store.box<DatabaseLayoutSettings>();

  Box<DatabaseInterfaceSettings> get interfaceSettingsBox =>
      store.box<DatabaseInterfaceSettings>();

  Box<DatabasePlayerSettings> get playerSettingsBox =>
      store.box<DatabasePlayerSettings>();

  Box<UserProfile> get userBox => store.box<UserProfile>();

  Box<DatabaseSettings> get settingsBox => store.box<DatabaseSettings>();

  Box<Album> get albumBox => store.box<Album>();

  Box<Artist> get artistBox => store.box<Artist>();

  Box<Genre> get genreBox => store.box<Genre>();

  Box<Playlist> get playlistBox => store.box<Playlist>();

  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(directory: p.join(docsDir.path, "obx"));
    return ObjectBox._create(store);
  }
}
