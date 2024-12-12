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

  void save(Entity artist) {
    box.put(artist);
  }

  void saveAll(List<Entity> entities) {
    box.putMany(entities);
  }

  void saveAllManually(List<Entity> entities) {
    for (final entity in entities) {
      save(entity);
    }
  }

  Future<void> saveAllAsync(List<Entity> artists) async {
    box.putManyAsync(artists);
  }

  removeAll() {
    box.removeAll();
  }
}
