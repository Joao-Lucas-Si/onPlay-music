import 'package:onPlay/database/objectbox.obx.dart';
import 'package:onPlay/models/genre.dart';
import 'package:onPlay/models/managers/base_manager.dart';

class GenreManager extends BaseManager<Genre> {
  GenreManager(super.box);

  void remove(Genre genre) {
    box.remove(genre.id);
  }

  void removeEmpty() {
    box.query(Genre_.songs.relationCount(0)).build().remove();
  }
}
