import 'package:onPlay/database/objectbox.g.dart';
import 'package:onPlay/models/album.dart';

class AlbumManager {
  Box<Album> albumBox;

  AlbumManager(this.albumBox);

  List<Album> getAll() {
    return albumBox.getAll();
  }

  // List<Song> where() {
  //   return songBox.get
  // }

  int count() {
    return albumBox.count();
  }

  save(Album album) {
    albumBox.put(album);
  }

  saveAll(List<Album> albums) {
    albumBox.putMany(albums);
  }

  removeAll() {
    albumBox.removeAll();
  }
}
