import 'package:objectbox/objectbox.dart';
import 'package:onPlay/models/genre.dart';

class GenreManager {
  Box<Genre> genreBox;

  GenreManager(this.genreBox);

  List<Genre> getAll() {
    return genreBox.getAll();
  }

  // List<Song> where() {
  //   return songBox.get
  // }

  int count() {
    return genreBox.count();
  }

  save(Genre genre) {
    genreBox.put(genre);
  }

  saveAll(List<Genre> genres) {
    genreBox.putMany(genres);
  }

  removeAll() {
    genreBox.removeAll();
  }

  remove(Genre genre) {
    genreBox.remove(genre.id);
  }
}
