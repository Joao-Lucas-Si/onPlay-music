import 'dart:typed_data';

import 'package:onPlay/models/song.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Genre {
  @Id()
  int id = 0;
  String name;

  @Property(type: PropertyType.byteVector)
  Uint8List? picture;

  @Backlink("genre")
  final songs = ToMany<Song>();

  Genre({required this.name, this.picture});

  @override
  bool operator ==(Object other) {
    if (other is Genre) {
      return (other.id != 0 && id != 0 && other.id == id) || other.name == name;
    }
    return false;
  }
}
