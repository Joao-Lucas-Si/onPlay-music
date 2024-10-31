import 'package:onPlay/models/managers/base_manager.dart';
import 'package:onPlay/models/song.dart';

class SongManager extends BaseManager<Song> {
  SongManager(super.box);

  remove(Song song) {
    box.remove(song.id);
  }
}
