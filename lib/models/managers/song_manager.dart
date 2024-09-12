import 'package:onPlay/database/objectbox.g.dart';
import 'package:onPlay/models/song.dart';

class SongManager {
  Box<Song> songBox;

  SongManager(this.songBox);

  List<Song> getAll() {
    return songBox.getAll();
  }

  // List<Song> where() {
  //   return songBox.get
  // }

  int count() {
    return songBox.count();
  }

  save(Song song) {
    songBox.put(song);
  }

  saveAll(List<Song> songs) {
    songBox.putMany(songs);
  }

  removeAll() {
    songBox.removeAll();
  }

  remove(Song song) {
    songBox.remove(song.id);
  }
}
