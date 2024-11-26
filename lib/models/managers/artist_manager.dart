import 'package:onPlay/database/objectbox.obx.dart';
import 'package:onPlay/models/artist.dart';
import 'package:onPlay/models/managers/base_manager.dart';

class ArtistManager extends BaseManager<Artist> {
  ArtistManager(super.box);

  remove(Artist artist) {
    box.remove(artist.id);
  }

  void removeEmpty() {
    box.query(Artist_.songs.relationCount(0)).build().remove();
  }
}
