import 'package:onPlay/database/objectbox.g.dart';
import 'package:onPlay/dto/album.dart';
import 'package:onPlay/dto/artist.dart';
import 'package:onPlay/dto/genre.dart';
import 'package:onPlay/dto/song.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  Box<Song> get boxSong => store.box<Song>();

  Box<Album> get albumBox => store.box<Album>();

  Box<Artist> get artistBox => store.box<Artist>();

  Box<Genre> get genreBox => store.box<Genre>();

  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store =
        await openStore(directory: p.join(docsDir.path, "obx-example"));
    return ObjectBox._create(store);
  }
}
