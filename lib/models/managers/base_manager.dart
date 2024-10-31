import 'package:objectbox/objectbox.dart';

class BaseManager<Entity> {
  Box<Entity> box;

  BaseManager(this.box);

  List<Entity> getAll() {
    return box.getAll();
  }

  // List<Song> where() {
  //   return songBox.get
  // }

  int count() {
    return box.count();
  }

  Future<int> saveAsync(Entity entity) async {
    return box.putAsync(entity);
  }

  save(Entity artist) {
    box.put(artist);
  }

  saveAll(List<Entity> artists) {
    box.putMany(artists);
  }

  removeAll() {
    box.removeAll();
  }
}
