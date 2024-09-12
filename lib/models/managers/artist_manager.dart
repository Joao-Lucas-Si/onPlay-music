import 'package:onPlay/database/objectbox.g.dart';
import 'package:onPlay/models/artist.dart';

class ArtistManager {
  Box<Artist> artistBox;

  ArtistManager(this.artistBox);

  List<Artist> getAll() {
    return artistBox.getAll();
  }

  // List<Song> where() {
  //   return songBox.get
  // }

  int count() {
    return artistBox.count();
  }

  save(Artist artist) {
    artistBox.put(artist);
  }

  saveAll(List<Artist> artists) {
    artistBox.putMany(artists);
  }

  removeAll() {
    artistBox.removeAll();
  }

  remove(Artist artist) {
    artistBox.remove(artist.id);
  }
}
