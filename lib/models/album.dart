import 'dart:typed_data';

import 'package:onPlay/models/artist.dart';
import 'package:onPlay/models/song.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Album {
  @Id()
  int id = 0;
  String name = "";

  @Property(type: PropertyType.byteVector)
  Uint8List? picture;

  final artist = ToOne<Artist>();

  @Backlink("album")
  final songs = ToMany<Song>();

  Album({required this.name, this.picture});

  @override
  bool operator ==(Object other) {
    if (other is Album) {
      return (other.id != 0 && id != 0 && other.id == id) ||
          (other.name == name &&
              other.artist.target?.name == artist.target?.name);
    }
    return false;
  }
}
